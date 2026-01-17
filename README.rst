AWS Data Engineering Bootcamp
============================

Hands-On AWS Data Engineering Labs & Assignments
-----------------------------------------------

This repository contains a structured set of **hands-on labs and assignments** covering core AWS data engineering concepts — from ingestion and streaming to analytics, orchestration, and CI/CD patterns.

The content aligns with practical exercises you’d encounter in real data engineering workflows using AWS services like Lambda, Kinesis, Glue, EMR, Redshift, Step Functions and more.

Repository Contents
-------------------

.. code::

    aws_data_engineering_bootcamp/
    ├── assignment1_mysql_aurora/
    ├── assignment2_glue_pyspark_athena/
    ├── assignment3_kinesis_lambda/
    ├── assignment4_kinesis_pyspark/
    ├── assignment5_cicd_lambda/
    ├── lab1_airflow_redshift_dynamo/
    ├── lab2_airflow_spark_dynamo/
    ├── lab3_stepfunctions_glue_redshift/
    ├── lab4_emr_s3_athena/
    ├── lab5_ecs_stepfunctions/
    ├── lab6_pyspark_glue_s3_athena/
    ├── lab7_kinesis_lambda_glue_dynamodb/
    ├── lab8_pyspark_glue_kinesis/
    ├── lab9_cicd_githubactions_lambda_glue_ecs/
    ├── lab10_kinesis_firehose_lambda_redshift/
    ├── udemy-aws-de-labs/      # Supporting Udemy lab content
    ├── requirements.txt
    ├── .gitmodules
    └── readme.txt

Getting Started
---------------

To start working with the materials:

1. Clone this repository::

       git clone https://github.com/9778060/aws_data_engineering_bootcamp.git

2. Create and activate a Python virtual environment::

       python3 -m venv venv
       source venv/bin/activate

3. Install dependencies::

       pip install -r requirements.txt

4. Review individual assignment/lab folders in order: start with **assignment1**, then move into **assignment2**, etc.

Summary of Labs & Assignments
-----------------------------

**Assignments**  
* `assignment1_mysql_aurora/` – Set up Aurora MySQL and explore ingestion basics.  
* `assignment2_glue_pyspark_athena/` – Glue PySpark jobs + Athena queries.  
* `assignment3_kinesis_lambda/` – Streaming ingestion with Kinesis & Lambda.  
* `assignment4_kinesis_pyspark/` – Kinesis with PySpark processing.  
* `assignment5_cicd_lambda/` – CI/CD for Lambda workflows.

**Labs**  
* `lab1_airflow_redshift_dynamo/` – Airflow orchestration with Redshift & DynamoDB.  
* `lab2_airflow_spark_dynamo/` – Airflow + Spark + DynamoDB patterns.  
* `lab3_stepfunctions_glue_redshift/` – AWS Step Functions + Glue + Redshift ETL.  
* `lab4_emr_s3_athena/` – EMR batch processing with S3 and Athena analytics.  
* `lab5_ecs_stepfunctions/` – ECS & Step Functions for containerized pipelines.  
* `lab6_pyspark_glue_s3_athena/` – PySpark transformations in Glue with Athena.  
* `lab7_kinesis_lambda_glue_dynamodb/` – Streaming + Lambda + Glue + DynamoDB.  
* `lab8_pyspark_glue_kinesis/` – PySpark + Glue pipeline for Kinesis data.  
* `lab9_cicd_githubactions_lambda_glue_ecs/` – Full CI/CD with GitHub Actions.  
* `lab10_kinesis_firehose_lambda_redshift/` – Firehose + Lambda loading into Redshift.

Learning Objectives
-------------------

By working through this repository, you should be able to:

* Design and deploy end-to-end data pipelines on AWS.
* Work with both batch and streaming data processing.
* Use AWS analytics services such as Athena and Redshift for insights.
* Automate workflows using Airflow, Step Functions and CI/CD.
* Integrate core AWS services with Python, PySpark and serverless logic.

Prerequisites
-------------

Before you begin, you should have:

* An AWS account with appropriate IAM permissions.
* AWS CLI configured locally.
* Python 3.x environment with virtualenv.
* Basic familiarity with AWS services (S3, Lambda, Kinesis, Glue).
* Optional: Docker installed for local orchestration testing.

Important Notes
---------------

* Running AWS resources will incur charges. Always monitor and clean up after use.
* Use smallest test configurations (t2/micro, minimal clusters) to reduce costs.
* Security configurations in this repo are for learning — not hardened for production.

Cleaning up Resources
---------------------

Always delete AWS resources created during labs to avoid ongoing charges:

* Terminate EMR clusters when finished.
* Delete Lambda functions and associated log groups.
* Remove Kinesis streams and Firehose deliveries.
* Drop temporary databases or Redshift clusters.

License
-------

This repository is provided for educational use. See the repository itself for any licensing files.

Author
------

This project was created as part of a personal AWS data engineering learning curriculum.

