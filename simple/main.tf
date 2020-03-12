terraform {
  required_version = "= 0.12.23"
  backend "s3" {
    bucket = "mcorr-terraform-state"
    key    = "presentation/simple-demo.tfstate"
    region = "ap-southeast-2"
  }
}

# aws account is defined in ~/.aws/credentials and the AWS_PROFILE env var is set
provider "aws" {
  region  = var.aws_region
  version = ">2.50.0"
}

# get info about the Virtual Private Cloud
data "aws_vpc" "current_vpc" {
  id = var.vpc_id
}

# Create the resources
resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "Demo"
  }
}

resource "aws_sqs_queue" "message_queue" {
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  name                      = format("%s.fifo", var.sqs_name)
  fifo_queue                = true
  tags = {
    Environment = "Demo"
    VPC_ARN  = data.aws_vpc.current_vpc.arn
  }
}

