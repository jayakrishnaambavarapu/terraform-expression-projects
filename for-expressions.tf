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
#checking if condition in for loop
variable "for-if-condition" {
  type = map(object({
    name = string
    is_admin = bool
  }))
  default = {
   user1 =  {
      name = "jayakrishna"
      is_admin = false
    },

   user2 =  {
      name = "dheeraj"
      is_admin = true
    }
  }
}

output "if-condition-result" {
  value = {for name, user in var.for-if-condition : name => user if user.name == "jayakrishna"}
# name variable display key values ( user1 & user2 ), user variable displays values ( it is similar to key value pair)
}


