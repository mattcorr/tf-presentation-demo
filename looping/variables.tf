variable "vpc_id" {
  type        = string
  description = "The Virtual Private Cloud Id for the AWS sub"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use for storing our resources"
  default     = "ap-southeast-2"
}

variable "s3_bucket_names" {
  type        = list(string)
  description = "The names of the S3 buckets to create"
}

variable "sqs_data" {
  type = map(object({
    delay             = number
    max_msg_size      = number
    receive_wait_secs = number
    environment       = string
  }))
  description = "Data object representing fields for SQS resources to create"
}
