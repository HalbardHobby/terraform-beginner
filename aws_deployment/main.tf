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

resource "aws_security_group" "server_group" {
  name        = "TF_server_group"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_group" {
  name        = "TF_db_group"
  description = "Allow traffic only from servers"
  vpc_id      = aws_vpc.vpc_main.id
}

resource "aws_security_group_rule" "allow_inggress_from_servers" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = aws_security_group.db_group.id
  source_security_group_id = aws_security_group.server_group.id
}

module "ec2" {
  source = "./ec2"

  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = "161.0.11.0/24"
  security_group_id = aws_security_group.server_group.id
}

module "rds" {
  source = "./RDS"

  vpc_id       = aws_vpc.vpc_main.id
  cidr_block_0 = "161.0.151.0/24"
  cidr_block_1 = "161.0.121.0/24"
  security_group_id = aws_security_group.db_group.id
}
