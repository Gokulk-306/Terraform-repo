variable "aws_region" {
  description = "AWS region"
  type        = string
}


variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string

  validation {
    condition = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Instance type must be t2 micro or t3 micro"
  }
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_groups" {
  description = "Security groups list"
  type        = list(string)
}

variable "instance_name" {
  description = "Instance tag name"
  type        = string
}

variable "instance_count" {
  type = number
  validation {
    condition = var.instance_count > 0 && var.instance_count <= 5
    error_message = "Instance count should be in between 1-5"
  }
}
variable "instances" {
  type = map(object({
    ami = string
    type = string
  }))
  default = {}
}