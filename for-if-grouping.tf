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


variable "for-if-condition" {
  type = map(object({
    name = string
#    is_admin = bool
  }))
  default = {
   user1 =  {
      name = "jayakrishna"
#      is_admin = false
    },

   user2 =  {
      name = "jayakrishna"
#      is_admin = true
    }
  }
}

output "if-condition-result" {
#   value = {for name, user in var.for-if-condition : name => user if user.name == "jayakrishna"}
   value = { for name, user in var.for-if-condition : user.name => name... }
#(...) this is grouping mode in terraform which allows to group multiple values per key and it produces a output and that output type is map(list(strings))
}


