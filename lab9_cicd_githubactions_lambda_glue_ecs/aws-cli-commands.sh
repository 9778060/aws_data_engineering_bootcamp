# Zip the python script for lambda 
zip function.zip lambda_function.py

# Deploy Lambda function
aws lambda create-function --function-name test-lambda \
--zip-file fileb://function.zip \
--handler lambda_function.lambda_handler \
--runtime python3.11 \
--role arn:aws:iam::...:role/custom-lambda-kinesis-dynamodb

# AWS Glue deployment

# Copy python script to S3
aws s3 cp mysql_extraction.py s3://.../glue-scripts/

# Deploy glue job using the uploaded script from S3 
aws glue create-job --name "mysql-extraction-job" --role "arn:aws:iam::...:role/custom-lambda-kinesis-dynamodb" \
--command '{"Name":"deploy-mysql-extraction", "ScriptLocation":"s3://.../glue-scripts/mysql_extraction.py", "PythonVersion":"3"}' --glue-version "4.0" --max-capacity 1


# Create OIDC provider for GitHub Actions
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1

# List OIDC providers
aws iam list-open-id-connect-providers
