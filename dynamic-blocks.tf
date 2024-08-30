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


locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 80
      description = "Ingree rules for port 80"
   }]
}

resource "aws_security_group" "main" {
   name   = "resource_with_dynamic_block"
   vpc_id = "vpc-0bbf61891a9cc6e81"

   dynamic "ingress" {
      for_each = local.ingress_rules
      iterator = ingress-1
      content {
         description = ingress-1.value.description
         from_port   = ingress-1.value.port
         to_port     = ingress-1.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   }

   tags = {
      Name = "AWS security group dynamic block"
   }
}





