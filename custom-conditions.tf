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

/*# validation block is used only in input variables, just checking validation block
variable "image_id" {
   type = string
   validation {
      condition = length(var.image_id) > 4 && substr(var.image_id,0,4) == "ami-"
      error_message = "ami is not a valid one"
   }
}*/
# checking if cidr-block condition fails whether the vpc resource will be created or not, if the validation condition fails then i will not create vpc resource
/*variable "cidr-block" {
   type = string
   validation {
      condition = var.cidr-block == "10.10.0.0/16"
      error_message = "cidr-block is not a valid one"
   }

}

resource "aws_vpc" "jaya-vpc" {
  cidr_block = var.cidr-block
  lifecycle {
    postcondition {
      condition = self.cidr_block == "10.10.0.0/16"
      error_message = "you need to change cidr block value"
    }


  }
}

output "result" {
  value = aws_vpc.jaya-vpc.cidr_block
  precondition {
     condition = aws_vpc.jaya-vpc.cidr_block == "10.100.0.0/16"
     error_message = "change cidr block value"
  }
  

}*/

data "aws_ami" "ami-example" {
    most_recent = true
    filter {
       name = "image-id"
       values = ["ami-04cdc91e49cb06165"]
    }
     filter {
        name = "owner-id"
        values = ["099720109477"]
     }
}

output "result" {
  value = data.aws_ami.ami-example
}



resource "aws_instance" "web" {
  ami           = data.aws_ami.ami-example.image_id
  instance_type = "t3.micro"
  key_name = "jk-demo"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  
  tags = {
    Name = "HelloWorld"
  }
  lifecycle {
#    precondition {
#       condition = data.aws_ami.ami-example.architecture == "x86_64"
#       error_message = "ami architecture is not arm64"
#    }

    
    postcondition {
       condition = self.associate_public_ip_address == false
       error_message = "key name is not pk demo"
    }
  }
}

/* documentation for aws_instance.web resource

important points
1. if precondition block failed then it prevents from resources being created ( this scenario only applies when values(data.aws_ami.ami-example.architecture known before the apply command)
2. generally in precondition block values are known before the terraform apply command
3. if postcondition block failed then it prevents from resources being created ( this scenario only applies when values known before the apply command )
4. if values are known after the terraform apply command for postcondition block, then if the condition becomes false in that scenario terraform creates the resources but if we are changing any values or adding attributes in that resource, it will not update that resource because of postcondition block failure.
5. failed postcondition block prevents any further downstream action that rely on the resource, but does not undo the actions terraform has already taken.

*/




