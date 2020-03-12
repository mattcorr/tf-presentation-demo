# define the variables in the variables.tf file

# use the TF_VAR_vpc_id env to set this value before you run tf commands

# Use the default for aws_region

# for other users of this git repo, change the values below

s3_bucket_names = [
  "looping-demo-one-s3-mcorr2020",
  "looping-demo-two-s3-mcorr2020",
  "looping-demo-three-s3-mcorr2020",
  "looping-demo-four-s3-mcorr2020"]

sqs_data = {
  matt_test_one = {
    delay             = 10
    max_msg_size      = 1024
    receive_wait_secs = 10
    environment       = "dev"
  },
  matt_test_two = {
    delay             = 10
    max_msg_size      = 2048
    receive_wait_secs = 9
    environment       = "test"
  },
  matt_test_three = {
    delay             = 5
    max_msg_size      = 4096
    receive_wait_secs = 5
    environment       = "prod"
  }
}
