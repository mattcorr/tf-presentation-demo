# define the variables in the variables.tf file

# use the TF_VAR_vpc_id env to set this value before you run tf commands

# Use the default for aws_region

# for other users of this git repo, change the values below

s3_bucket_names = [
  "mod-demo-one-s3-mcorr2020",
  "mod-demo-two-s3-mcorr2020",
  "mod-demo-three-s3-mcorr2020",
  "mod-demo-four-s3-mcorr2020"]

sqs_queues = {
  matt_mod_test_one = {
    delay              = 10
    redrive            = 5
    retention          = 345600
    max_msg_size       = 1024
    receive_wait_secs  = 10
    visibility_timeout = 600
    environment        = "dev"
  },
  matt_mod_test_two = {
    delay              = 10
    redrive            = 5
    retention          = 345600
    max_msg_size       = 2048
    receive_wait_secs  = 10
    visibility_timeout = 500
    environment        = "test"
  },
  matt_mod_test_three = {
    delay              = 10
    redrive            = 5
    retention          = 345600
    max_msg_size       = 2048
    receive_wait_secs  = 10
    visibility_timeout = 500
    environment        = "uat"
  },
  matt_mod_test_four = {
    delay              = 10
    redrive            = 5
    retention          = 345600
    max_msg_size       = 4096
    receive_wait_secs  = 10
    visibility_timeout = 600
    environment        = "prod"
  }
}

