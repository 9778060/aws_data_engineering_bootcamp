from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.operators.empty import EmptyOperator
from datetime import datetime, timedelta
import boto3
import logging
import time

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.now() - timedelta(days=1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=1)
}

REGION_NAME = 'us-east-1'
BUCKET_NAME = ''
SONGS_FILE_PATH = 'spotify_data/songs/'
USERS_FILE_PATH = 'spotify_data/users/'
STREAMS_PREFIX = 'spotify_data/user-streams/'
ARCHIVE_PREFIX = 'spotify_data/user-streams-archived/'


dag = DAG('process-songs-metrics',
          default_args=default_args,
          description='Trigger Glue job when new files are uploaded to S3 and manage output',
          schedule='*/30 * * * *',
          catchup=False)

def check_files_in_s3(prefix):
    s3 = boto3.client('s3')
    bucket_name = BUCKET_NAME
    
    response = s3.list_objects_v2(Bucket=bucket_name, Prefix=prefix)
    contents = response.get('Contents', [])
    logging.info(f"Contents in {prefix}: {contents}")

    for obj in contents:
        if obj['Size'] > 0:
            logging.info(f"Non-empty file found in {prefix}: {obj['Key']}")
            return True

    logging.info(f"No non-empty files found in {prefix}")
    return False

def check_all_files(**kwargs):
    logging.info("Checking for files in S3 prefixes")
    user_streams = check_files_in_s3(STREAMS_PREFIX)
    songs = check_files_in_s3(SONGS_FILE_PATH)
    users = check_files_in_s3(USERS_FILE_PATH)
    
    logging.info(f"user_streams: {user_streams}, songs: {songs}, users: {users}")
    
    if user_streams and songs and users:
        logging.info("All directories have files, proceeding with Spark job")
        return 'trigger_spark_job_task'
    else:
        logging.info("One or more directories are missing files, skipping execution")
        return 'skip_execution'

def wait_for_glue_job_completion(job_name, client, poll_interval=60):
    while True:
        response = client.get_job_runs(JobName=job_name, MaxResults=1)
        job_runs = response.get('JobRuns', [])
        
        if job_runs and job_runs[0]['JobRunState'] in ['RUNNING', 'STARTING', 'STOPPING']:
            logging.info(f"Glue job {job_name} is still running. Waiting for it to finish...")
            time.sleep(poll_interval)
        else:
            logging.info(f"Glue job {job_name} has finished.")
            break

def trigger_glue_job(job_name, **kwargs):
    client = boto3.client('glue', region_name=REGION_NAME)
    logging.info(f"Checking if Glue job {job_name} is running...")
    wait_for_glue_job_completion(job_name, client)
    logging.info(f"Triggering Glue job: {job_name}")
    response = client.start_job_run(JobName=job_name)

def wait_for_spark_job_completion(**kwargs):
    glue_job_name = 'calculate_metrics_etl'
    client = boto3.client('glue', region_name=REGION_NAME)
    wait_for_glue_job_completion(glue_job_name, client)

def wait_for_python_job_completion(**kwargs):
    glue_job_name = 'insert_metrics_dynamo'
    client = boto3.client('glue', region_name=REGION_NAME)
    wait_for_glue_job_completion(glue_job_name, client)

def move_files_to_archived(source_prefix, dest_prefix, **kwargs):
    s3 = boto3.client('s3')
    bucket = BUCKET_NAME

    response = s3.list_objects_v2(Bucket=bucket, Prefix=source_prefix)
    for obj in response.get('Contents', []):
        source_key = obj['Key']
        dest_key = source_key.replace(source_prefix, dest_prefix)

        s3.copy_object(Bucket=bucket, CopySource={'Bucket': bucket, 'Key': source_key}, Key=dest_key)
        s3.delete_object(Bucket=bucket, Key=source_key)

check_files = BranchPythonOperator(
    task_id='check_files',
    python_callable=check_all_files,
    dag=dag
)

trigger_spark_job_task = PythonOperator(
    task_id='trigger_spark_job_task',
    python_callable=trigger_glue_job,
    op_args=['calculate_metrics_etl'],
    dag=dag
)

wait_for_spark_job_completion_task = PythonOperator(
    task_id='wait_for_spark_job_completion_task',
    python_callable=wait_for_spark_job_completion,
    dag=dag
)
trigger_python_job_task = PythonOperator(
    task_id='trigger_python_job_task',
    python_callable=trigger_glue_job,
    op_args=['insert_metrics_dynamo'],
    dag=dag
)

wait_for_python_job_completion_task = PythonOperator(
    task_id='wait_for_python_job_completion_task',
    python_callable=wait_for_python_job_completion,
    dag=dag
)

move_files_streams = PythonOperator(
    task_id='move_files_streams',
    python_callable=move_files_to_archived,
    op_args=[STREAMS_PREFIX, ARCHIVE_PREFIX],
    dag=dag
)

skip_execution = EmptyOperator(
    task_id='skip_execution',
    dag=dag
)

# Setup the task dependencies
check_files >> [trigger_spark_job_task, skip_execution]
trigger_spark_job_task >> wait_for_spark_job_completion_task >> trigger_python_job_task >> wait_for_python_job_completion_task >> move_files_streams