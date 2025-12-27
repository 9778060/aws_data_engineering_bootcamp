#!/bin/bash

# Detect current directory as workspace
WORKSPACE_LOCATION=$(pwd)

# Default script filename
DEFAULT_SCRIPT="glue-pyspark.py"

# Check if user passed a script name as argument
if [ -z "$1" ]; then
    SCRIPT_FILE_NAME="$DEFAULT_SCRIPT"
    echo "No script name provided. Using default: $SCRIPT_FILE_NAME"
else
    SCRIPT_FILE_NAME="$1"
    echo "Using script: $SCRIPT_FILE_NAME"
fi

echo "Running AWS Glue container..."
echo "Workspace: $WORKSPACE_LOCATION"
echo "Script: $SCRIPT_FILE_NAME"

docker run -it \
  -v ~/.aws:/home/glue_user/.aws:ro \
  -v "${WORKSPACE_LOCATION}:/home/glue_user/workspace/" \
  -e AWS_SHARED_CREDENTIALS_FILE=/home/glue_user/.aws/credentials \
  -e AWS_CONFIG_FILE=/home/glue_user/.aws/config \
  -e AWS_PROFILE=default \
  -e AWS_SDK_LOAD_CONFIG=1 \
  -e DISABLE_SSL=true \
  --rm \
  -p 4040:4040 \
  -p 18080:18080 \
  --name glue_spark_submit \
  public.ecr.aws/glue/aws-glue-libs:5 \
  spark-submit "/home/glue_user/workspace/${SCRIPT_FILE_NAME}"
