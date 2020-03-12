output "s3_output" {
  value = zipmap( values(aws_s3_bucket.bucket)[*].bucket, values(aws_s3_bucket.bucket)[*].arn )
}

# shows how a project can reference output variables from a module
output "sqs_output" {
  value = module.sqs.sqs_output
  description = "The list of sqs resources created from the SQS module"
}
