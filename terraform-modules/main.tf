terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }

  required_version = ">= 1.3.0"

  backend "s3" {
    bucket = "terrform-state-east-2"
    key = "dev/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2_server" {
  source = "./modules/ec2_instance"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  security_groups = var.security_groups
  subnet_id       = var.subnet_id
  instance_name   = var.instance_name
}