output "s3_output" {
  value = aws_s3_bucket.bucket.arn
}

output "sqs_output" {
  value = aws_sqs_queue.message_queue.arn
}