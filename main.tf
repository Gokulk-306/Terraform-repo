provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "demo-server" {
    ami = "ami-0cfde0ea8edd312d4"
    instance_type = "t3.micro"
}
