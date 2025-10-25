
resource "aws_instance" "Name" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}