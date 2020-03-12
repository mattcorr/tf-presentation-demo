output "s3_output" {
  value = zipmap( values(aws_s3_bucket.bucket)[*].bucket, values(aws_s3_bucket.bucket)[*].arn )
}

output "sqs_output" {
  value = zipmap( values(aws_sqs_queue.message_queue)[*].name, values(aws_sqs_queue.message_queue)[*].arn ) 
}
