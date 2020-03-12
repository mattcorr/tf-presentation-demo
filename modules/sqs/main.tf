resource "aws_sqs_queue" "dlqs" {
  for_each = var.sqs_queues_fifo

  name                       = "${each.key}-dlq.fifo"
  fifo_queue                 = true
  message_retention_seconds  = each.value["retention"]
  delay_seconds              = each.value["delay"]
  max_message_size           = each.value["max_msg_size"]
  receive_wait_time_seconds  = each.value["receive_wait_secs"]
  visibility_timeout_seconds = each.value["visibility_timeout"]
  tags = {
    Environment = each.value["environment"]
  }
}

resource "aws_sqs_queue" "poison" {
  for_each = var.sqs_queues_fifo

  name                       = "${each.key}-poison.fifo"
  fifo_queue                 = true
  message_retention_seconds  = each.value["retention"]
  delay_seconds              = each.value["delay"]
  max_message_size           = each.value["max_msg_size"]
  receive_wait_time_seconds  = each.value["receive_wait_secs"]
  visibility_timeout_seconds = each.value["visibility_timeout"]
  tags = {
    Environment = each.value["environment"]
  }
}

resource "aws_sqs_queue" "message_queue" {
  for_each = var.sqs_queues_fifo

  name                       = "${each.key}.fifo"
  fifo_queue                 = true
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dlqs[each.key].arn}\",\"maxReceiveCount\":${each.value["redrive"]}}"
  message_retention_seconds  = each.value["retention"]
  delay_seconds              = each.value["delay"]
  max_message_size           = each.value["max_msg_size"]
  receive_wait_time_seconds  = each.value["receive_wait_secs"]
  visibility_timeout_seconds = each.value["visibility_timeout"]
  tags = {
    Environment = each.value["environment"]
  }
}

data "aws_caller_identity" "current" {}

resource "aws_sqs_queue_policy" "test" {
  for_each = var.sqs_queues_fifo

  queue_url = aws_sqs_queue.message_queue[each.key].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SQSProdAccessPolicy",
  "Statement": [
    {
      "Sid": "Sid1497844230020",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "SQS:*",
      "Resource": "${aws_sqs_queue.message_queue[each.key].arn}"
    }
  ]
}
POLICY

}

