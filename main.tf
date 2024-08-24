variable "set-example" {
  type = set(string)
  default = ["10.10.0.0/16","10.20.0.0/16","10.10.0.0/16"]
}

output "printing" {
  value = var.set-example
}

#sets doesn't have any ordering or indexing so we can't iterate over set, to iterate set we need to convert set into list.
