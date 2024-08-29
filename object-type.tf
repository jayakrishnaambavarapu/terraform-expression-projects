variable "user" {
  type = object({
    name  = string
    email = string
    age   = number
  })
  default = {
    name  = "Sam"
    email = "sam@example.com"
    age   = 30
  }
}

output "printing-result" {
  value = {
    name = var.user.name
    email = var.user.email
    age = var.user.age
  }
# in object type the the values of object can be called by their attribute name

}
