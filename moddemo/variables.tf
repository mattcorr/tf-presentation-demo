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

variable "sqs_queues" {
  type = map(object({
    redrive            = number
    retention          = number
    delay              = number
    max_msg_size       = number
    receive_wait_secs  = number
    visibility_timeout = number
    environment        = string
  }))
  description = "Data object passed to the sqs module"
}

