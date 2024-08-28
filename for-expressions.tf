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

#for-expression-example
variable "for-checking" {
  type = list(string)
  default = ["jayakrishna","dheeraj"]
}
#for-expression-example-1
variable "for-map-checking" {
  type = map(string)
  default = {
   "jayakrishna" = "working"
    "dheeraj" = "accenture"
  }


}

#converting list values into uppercase letters
output "printing-for-result" {
  value = { for i in var.for-checking : i => upper(i) }
}
#printing index value and element value for a list by using two temporary variables
output "result-1" {
  value = { for k,v in var.for-checking : k => v }
}

#it will display value only from a map and the result will be a list
output "printing-result" {
  value = [ for j in var.for-map-checking : j]

}
