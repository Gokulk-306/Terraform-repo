provider "aws" {
  region = "us-east-2"
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
    Name = "demo-SG"
  }
}

resource "aws_instance" "web" {
  count                       = 2
  ami                         = "ami-0cfde0ea8edd312d4" # Ubuntu 22.04 (ohio)
  instance_type               = "t3.micro"
  subnet_id                   = element(data.aws_subnets.default.ids, count.index)
  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  associate_public_ip_address = true


  tags = {
    Name = "Web-Server-${count.index + 1}"
    Env  = "Dev"
  }
# EOF is called "heredoc"
  user_data = <<-EOF
     #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "<h1>Hello from Web Server ${count.index + 1}</h1>" > /usr/share/nginx/html/index.html
    sudo systemctl enable nginx
    sudo systemctl start nginx
    EOF

}