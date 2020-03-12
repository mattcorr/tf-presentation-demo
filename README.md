# Summary
This git repo contains sample code for three separate [terraform](https://www.terraform.io/) projects.
These have been used for a presentation called **Introduction to Terraform**.

## Pre-requisites 
Ensure these are set in your terminal session before you start 
* Configure your AWS account via the `~/.aws/credentials` files and set the `AWS_PROFILE` accordingly.
* Set the `TF_VAR_vpc_id` env var to the VPC Id for where you wish to deploy these resources
* check the config for TODO for some values you might want to update for your personal context.

# Projects 
## Simple
A terraform project that deploys a single S3 bucket and SQS to AWS.
## Looping
A terraform project that deploys multiple S3 buckets and SQS to AWS using lists of strings and objects.
A good demo for the [for-each](https://www.terraform.io/docs/configuration/resources.html#for_each-multiple-resource-instances-defined-by-a-map-or-set-of-strings) command.
## Mod Demo
A terraform project that uses modules for creating some resources.

