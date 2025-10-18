provider "aws" {
  region = var.aws_region
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Allow HTTP, HTTPS, and SSH traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}

resource "aws_instance" "web" {
  count                       = 2
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(data.aws_subnets.default.ids, count.index)
  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

 
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "echo '<h1>Hello from Web Server ${count.index + 1}</h1>' | sudo tee /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/mnt/c/Users/Gokul/Downloads/IGW.pem")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo EC2 instance ${count.index + 1} created and configured >> instance_log.txt"
  }

  tags = {
    Name = "Web-Server-${count.index + 1}"
    Env  = "Dev"
  }
}
