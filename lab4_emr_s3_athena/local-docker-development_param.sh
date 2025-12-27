# Step 1: Validate Input
if [ -z "$1" ]; then
  echo "Usage: ./local-docker-development_param.sh script_name"
  exit 1
fi

SCRIPT_FILE_NAME=${1:-spark-agg1.py}
WORKSPACE_LOCATION=$(pwd)

docker run -it \
  -v ~/.aws:/home/glue_user/.aws:ro \
  -v ${WORKSPACE_LOCATION}:/home/glue_user/workspace/ \
  -e AWS_SHARED_CREDENTIALS_FILE=/home/glue_user/.aws/credentials \
  -e AWS_CONFIG_FILE=/home/glue_user/.aws/config \
  -e AWS_PROFILE=default \
  -e AWS_SDK_LOAD_CONFIG=1 \
  -e DISABLE_SSL=true \
  --rm \
  -p 4040:4040 -p 18080:18080 \
  --name glue_spark_submit \
  public.ecr.aws/glue/aws-glue-libs:5 \
  spark-submit /home/glue_user/workspace/${SCRIPT_FILE_NAME}
