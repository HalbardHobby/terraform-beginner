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

resource "aws_subnet" "private_subnet_0" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_0
  availability_zone = "us-east-2a"

  tags = {
    Name = "TF_private_subnet_0"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_1
  availability_zone = "us-east-2b"

  tags = {
    Name = "TF_private_subnet_1"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_0.id, aws_subnet.private_subnet_1.id]

  tags = {
    Name = "TF_db_subnet"
  }
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "13.3"
  instance_class      = "db.t3.micro"
  name                = "TF_db"
  username            = "example"
  password            = "example123"
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  tags = {
    Name = "TF_db"
  }
}
