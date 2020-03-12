variable "vpc_id" {
  type        = string
  description = "The Virtual Private Cloud Id for the AWS sub"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use for storing our resources"
  default     = "ap-southeast-2"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket we are creating"
}

variable "sqs_name" {
  type        = string
  description = "The name of the SQS we are creating"
}
