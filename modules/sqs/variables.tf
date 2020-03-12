variable "sqs_queues_fifo" {
  type = map(object({
    redrive            = number
    retention          = number
    delay              = number
    max_msg_size       = number
    receive_wait_secs  = number
    visibility_timeout = number
    environment        = string
  }))
}
