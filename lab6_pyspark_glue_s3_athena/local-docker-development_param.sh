
# Step 1: Validate Input
if [ -z "$1" ]; then
  echo "Usage: ./local-docker-development_param.sh param"
  exit 1
fi

SCRIPT_FILE_PARAM=${1:-orders}
WORKSPACE_LOCATION=$(pwd)
SCRIPT_FILE_NAME=spark-transactional-delta-lake.py

docker run -it \
  -v ~/.aws:/home/glue_user/.aws \
  -v "${WORKSPACE_LOCATION}:/home/glue_user/workspace/" \
  -v "${WORKSPACE_LOCATION}/jars:/home/glue_user/jars" \
  -e AWS_SHARED_CREDENTIALS_FILE=/home/glue_user/.aws/credentials \
  -e AWS_CONFIG_FILE=/home/glue_user/.aws/config \
  -e AWS_PROFILE=default \
  -e AWS_SDK_LOAD_CONFIG=1 \
  -e DISABLE_SSL=true \
  --rm \
  -p 4040:4040 \
  -p 18080:18080 \
  --name glue_spark_submit \
  spark-deltalake-job \
  spark-submit \
    --jars /home/glue_user/jars/delta-core_2.12-1.0.0.jar \
    /home/glue_user/workspace/${SCRIPT_FILE_NAME} \
    --table_name "${SCRIPT_FILE_PARAM}"