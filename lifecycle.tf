terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"
}

resource "aws_vpc" "jaya-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    name = "jaya-vpc"
  }
  lifecycle {
    ignore_changes = [ tags ]
  }
}
# in the lifecycle block we have mentioned ignore changes for tags field,if i have changed tags or added new tags or deleted tags it will not detect those changes

