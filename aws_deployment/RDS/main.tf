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

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = "db.t3.micro"
  name                 = "TF_db"
  username             = "example"
  password             = "example123"
  skip_final_snapshot  = true

  tags = {
    Name = "TF_db"
  }
}
