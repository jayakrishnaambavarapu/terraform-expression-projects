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
   vpc_id = ""
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
# iterator temporary variable is ingress-1 is a user defined variable, it takes for_each element and use that in content block to iterate, if iterator argument is not used in dynamic block
then dynamic name "ingress" is used as a iterator in content block
# ingress is a block in security group resource, instead of writing manually ingress & egress rules for security groups multiple times we can use dynamic blocks to create ingress blocks at
run time.
# dynamic name "ingress" is a valid security group resource name, we need to use valid block names for dynamic blocks




