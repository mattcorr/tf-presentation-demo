output "sqs_output" {
  value = zipmap( values(aws_sqs_queue.message_queue)[*].name, values(aws_sqs_queue.message_queue)[*].arn ) 
}