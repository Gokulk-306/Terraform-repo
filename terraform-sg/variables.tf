variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for deployment"
}
variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
  default     = "ami-0cfde0ea8edd312d4"
}
variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "IGW"   # <-- Make sure this matches your AWS key pair name
}
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for EC2"
}
variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
}
variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}
variable "sg_name" {
  type    = string
  default = "demo_sg"
}
variable "instance_name" {
  type    = string
  default = "Web-Server"
}