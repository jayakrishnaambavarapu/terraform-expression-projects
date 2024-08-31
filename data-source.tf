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

/*data "aws_vpc" "example" {
   filter {
     name = "tag:name"
     values = ["jaya-vpc"]
   }
}
data "aws_vpc" "example-1" {
   tags = {
     name = "jaya-vpc"

   }

}



output "result" {
#  value = data.aws_vpc.example
   value = data.aws_vpc.example.tags
}

output "result-1" {
   value = data.aws_vpc.example-1.id
}*/

# data.aws_vpc.example displays all attributes and their values of the vpc resource
# data.aws_vpc.example.tags it displays vpc tags information only

/*resource "aws_vpc" "jaya-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    name = "jaya-vpc"
  }
}

data "aws_vpc" "sample" {
  tags = {
    name = "jaya-vpc"
  }
  depends_on = [
     aws_vpc.jaya-vpc
  ]

}
# here in the sample data block we have mentioned depends_on meta argument, firstly the data block waits for vpc resource resource need to be created then after that it reads from that vpc
output "result-2" {
  value = data.aws_vpc.sample.id

}

output "result-3" {
  value = data.aws_vpc.sample.cidr_block
}*/


# using meta arguments like count&for_each in data source block
# steps
# step1: create two vpcs
# step2: create a data source and use meta arguments like count or for_each and filter with tag names or cidr-blocks

/*resource "aws_vpc" "jaya-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    name = "jaya-vpc-1"
  }
}
resource "aws_vpc" "jk-vpc" {
  cidr_block = "10.20.0.0/16"
  tags = {
    name = "jaya-vpc-2"
  }
}
locals {
 names = ["jaya-vpc-1","jaya-vpc-2"]

}

data "aws_vpc" "vpc-1" {
  count = 2
  tags = {
    name = local.names[count.index]
  }
  depends_on = [
     aws_vpc.jaya-vpc,aws_vpc.jk-vpc
  ]
}

output "using-meta-arguments-in-data-source-blocks" {
   value = data.aws_vpc.vpc-1[0].id
}*/

# using for_each meta arguments in data source block

resource "aws_vpc" "jaya-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    name = "jaya-vpc-1"
  }
}
resource "aws_vpc" "jk-vpc" {
  cidr_block = "10.20.0.0/16"
  tags = {
    name = "jaya-vpc-2"
  }
}

locals {
  name = { vpc-name-1 = "jaya-vpc-1", vpc-name-2 = "jaya-vpc-2" }

}
data "aws_vpc" "vpc-1" {
  for_each = local.name
  tags = {
    name = each.value
  }
  depends_on = [
     aws_vpc.jaya-vpc,aws_vpc.jk-vpc
  ]
}

output "using-meta-arguments-in-data-source-blocks" {
   value = [ for i, j in local.name : data.aws_vpc.vpc-1[i].id ]
}



