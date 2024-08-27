#provider.tf
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

#variable.tf
variable "vpc-tags" {
  type = string
  default = "terraform"
}

variable "vpc-owner" {
  type = string
  default = "aws"
}

#locals value

locals {
  name = ( var.vpc-tags != "" ? var.vpc-tags : var.vpc-owner )
  owner = var.vpc-owner
  common-tags = {
    Name = local.name
    Owner = local.owner
  }

}

#main.tf

resource "aws_vpc" "jaya-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = local.common-tags
}

#output.tf

output "checking-vpc-tags" {
  value = aws_vpc.jaya-vpc.tags
}
