# Terraform providers configuration with backend statefile locking

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
# This is the remote backend configuration. Your must create and s3 bucket
# that this configuration points to
  backend "s3" {
    bucket = "terraform-vpc-github-actions-backend"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = false # set to true to enable remote statefile locking
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}