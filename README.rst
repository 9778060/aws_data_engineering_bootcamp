AWS Data Engineering Bootcamp
============================

.. |badge1| image:: https://img.shields.io/badge/maturity-Beta-yellow.png
    :target: https://odoo-community.org/page/development-status
    :alt: Beta
.. |badge2| image:: https://img.shields.io/badge/License-MIT-blue.svg
    :target: https://opensource.org/licenses/MIT
    :alt: License: MIT

|badge1| |badge2|

Hands-On AWS Data Engineering Labs & Assignments
=======

This repository contains a structured set of **hands-on labs and assignments** covering core AWS data engineering concepts — from ingestion and streaming to analytics, orchestration, and CI/CD patterns.

The content aligns with practical exercises you’d encounter in real data engineering workflows using AWS services like Lambda, Kinesis, Glue, EMR, Redshift, Step Functions and more.

Repository Contents
=======

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
=======

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
=======

Assignments
=======

* ``assignment1_mysql_aurora/`` – Set up Aurora MySQL and explore ingestion basics.
* ``assignment2_glue_pyspark_athena/`` – Glue PySpark jobs and Athena queries.
* ``assignment3_kinesis_lambda/`` – Streaming ingestion with Kinesis and Lambda.
* ``assignment4_kinesis_pyspark/`` – Kinesis processing with PySpark.
* ``assignment5_cicd_lambda/`` – CI/CD pipelines for Lambda workflows.

Labs
----

* ``lab1_airflow_redshift_dynamo/`` – Airflow orchestration with Redshift and DynamoDB.
* ``lab2_airflow_spark_dynamo/`` – Airflow, Spark, and DynamoDB integration patterns.
* ``lab3_stepfunctions_glue_redshift/`` – AWS Step Functions with Glue and Redshift ETL.
* ``lab4_emr_s3_athena/`` – EMR batch processing using S3 and Athena.
* ``lab5_ecs_stepfunctions/`` – ECS and Step Functions for containerized pipelines.
* ``lab6_pyspark_glue_s3_athena/`` – PySpark transformations in AWS Glue with Athena.
* ``lab7_kinesis_lambda_glue_dynamodb/`` – Streaming pipelines with Kinesis, Lambda, Glue, and DynamoDB.
* ``lab8_pyspark_glue_kinesis/`` – PySpark and Glue pipelines for Kinesis data streams.
* ``lab9_cicd_githubactions_lambda_glue_ecs/`` – End-to-end CI/CD using GitHub Actions.
* ``lab10_kinesis_firehose_lambda_redshift/`` – Kinesis Firehose and Lambda loading data into Redshift.


Learning Objectives
=======

By working through this repository, you should be able to:

* Design and deploy end-to-end data pipelines on AWS.
* Work with both batch and streaming data processing.
* Use AWS analytics services such as Athena and Redshift for insights.
* Automate workflows using Airflow, Step Functions and CI/CD.
* Integrate core AWS services with Python, PySpark and serverless logic.

Prerequisites
=======

Before you begin, you should have:

* An AWS account with appropriate IAM permissions.
* AWS CLI configured locally.
* Python 3.x environment with virtualenv.
* Basic familiarity with AWS services (S3, Lambda, Kinesis, Glue).
* Optional: Docker installed for local orchestration testing.

Important Notes
=======

* Running AWS resources will incur charges. Always monitor and clean up after use.
* Use smallest test configurations (t2/micro, minimal clusters) to reduce costs.
* Security configurations in this repo are for learning — not hardened for production.

Cleaning up Resources
=======

Always delete AWS resources created during labs to avoid ongoing charges:

* Terminate EMR clusters when finished.
* Delete Lambda functions and associated log groups.
* Remove Kinesis streams and Firehose deliveries.
* Drop temporary databases or Redshift clusters.


Authors
=======

* 9778060
* Special credits and thanks to Sid Raghunath for his great AWS Data Engineering Bootcamp course, tutorials and resources (https://www.udemy.com/user/siddharth-raghunath/)

Maintainers
=======

This repository is maintained by **9778060**.