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


variable "list" {
  type = list(object({
    id   = string
    name = string
  }))
  
  default = [
    { id = "1", name = "Resource1" },
    { id = "2", name = "Resource2" },
    { id = "3", name = "Resource3" }
  ]
}

output "printing-result" {
 value = [ for i in var.list : i.id ]

}
