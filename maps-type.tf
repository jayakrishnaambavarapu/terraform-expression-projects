variable "map-checking" {
  type = map(string)
  default = {
    cidr = "10.10.0.0/16"
  }
}



resource "aws_vpc" "jaya-vpc" {
  cidr_block = var.map-checking["cidr"]

}

