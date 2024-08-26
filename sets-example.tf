variable "sets-example" {
  type = set(string)
  default = ["10.10.0.0/16","10.20.0.0/16"]
}


resource "aws_vpc" "jaya-vpc" {
  count = 2
  cidr_block = element(tolist(var.sets-example),count.index)

}

