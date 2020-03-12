terraform {
  required_version = "= 0.12.23"
  backend "s3" {
    bucket = "mcorr-terraform-state"
    key    = "presentation/looping-demo.tfstate"
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
  for_each = toset(var.s3_bucket_names)

  bucket = each.key
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "Demo"
  }
}

resource "aws_sqs_queue" "message_queue" {
  for_each = var.sqs_data

  delay_seconds             = each.value["delay"]
  max_message_size          = each.value["max_msg_size"]
  message_retention_seconds = 86400
  receive_wait_time_seconds = each.value["receive_wait_secs"]
  name                      = format("%s.fifo", each.key)
  fifo_queue                = true
  tags = {
    Environment = each.value["environment"]
    VPC_ARN     = data.aws_vpc.current_vpc.arn
  }
}

