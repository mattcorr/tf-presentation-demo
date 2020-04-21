terraform {
  required_version = ">= 0.12.23"
  backend "s3" {
    bucket = "mcorr-terraform-state"
    key    = "presentation/module-demo.tfstate"
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

# use a module this time to create a collection of related SQS resources and a policy
module "sqs" {
  source = "../modules/sqs"

  # pass our list of sqs metadata variable to the module variable
  sqs_queues_fifo = var.sqs_queues
}
