terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configuration for aws provider will be done through environment variables.
#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""
#export export AWS_REGION="us-west-1" or "us-east-1"
provider "aws" {}

