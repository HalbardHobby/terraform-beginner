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

resource "aws_subnet" "public_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "TF_public_subnet"
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0277b52859bac6f4b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [ var.security_group_id ]

  tags = {
    Name = "TF_instance"
  }
}