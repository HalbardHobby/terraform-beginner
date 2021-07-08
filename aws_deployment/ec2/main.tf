terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0277b52859bac6f4b"
  instance_type = "t2.micro"

  tags = {
    Name = "TF_instance"
  }
}