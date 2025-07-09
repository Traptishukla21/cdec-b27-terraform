provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my-sg" {
   name = "my-sg"
   description = "allow http port"

 ingress {
  from_port = 80
  to_port= 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
}

 egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpSxTmGmv0RfYnC8/rr5R73udtYYe0p89MCjCBxM0YFYouJm7l0ZXniDP4xbhaUAfLlhLHNHzrY+qrdQZaCmh4SHL3NQ9WQ7MmjM39+UPxHbUWIaN9OpCIg7XGxDPpH29MiHELXVk+8I4dQO+AmAy39r1iF7/nWok2q1IzLH+6hA236ler7JL+4iisQ2Mnl6/p5SjcD9GuMaJfRZTfeZa36jhg1Ix7+CNIWxFxKXbnik+n7rEeOpMlkd9odyJrMAdTnWR+UmTTdSFsMxpWSJhUvmvCX/ERrn9EBx+uFUkwFX2C3RcYWXqy2ttboCLWrrdV9HuEjXS0UFmF3ltJjyFH8caPDxM4Dc47HOtaPeLj3Brq7sMuDbr8RyiJzSVWVlXnSxl4pelzLl8Ier5+1Jwh3lIPbTjqDDimkk7h7Sv8l1pCmVuG2+Nte8o6wFHPoi2z9pSVa8XoRIhUoiMautVjO4w/tm2a0LrKbZDGjNC9uR+7u6dy9DYtgKRjrpO5KkE= root@ip-172-31-27-23.eu-north-1.compute.internal"
}

variable "imagine-id" {
  type = string
  description = "ami-id"
  default =  "ami-09e6f87a47903347c"
}






resource "aws_instance" "web" {
  ami       = var.imagine-id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name = aws_key_pair.deployer.key_name

      }
