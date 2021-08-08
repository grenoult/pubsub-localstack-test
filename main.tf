terraform {
  // TODO test with localstack!
  # backend "remote" {
  #   organization = "guillaume-renoult-org"
  #   workspaces {
  #     name = "guillaume-renoult-org"
  #   }
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  # profile = "default"
  # region  = "us-west-2"
  # access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  # secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    es             = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    route53        = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

resource "aws_sns_topic" "resourceA" {
    name = "gui-test-topic"
}

resource "aws_sqs_queue" "resourceB" {
    name = "gui-test-queue"
}

resource "aws_sns_topic_subscription" "results_updates_sqs_target" {
    topic_arn = aws_sns_topic.resourceA.arn
    protocol  = "sqs"
    endpoint  = aws_sqs_queue.resourceB.arn
}