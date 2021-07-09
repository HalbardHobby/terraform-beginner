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

resource "aws_vpc" "vpc_main" {
  cidr_block       = "161.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TF_vpc"
  }
}

module "ec2" {
  source = "./ec2"

  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "161.0.11.0/24"
}

module "rds" {
  source = "./RDS"

  vpc_id     = aws_vpc.vpc_main.id
  cidr_block_0 = "161.0.151.0/24"
  cidr_block_1 = "161.0.121.0/24"
}
