variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "security_groups" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Tag name for instance"
  type        = string
}

variable "instances" {
  type = map(object({
    ami = string
    type = string
  }))
  default = {}
}