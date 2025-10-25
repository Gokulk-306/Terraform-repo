output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.Name.id
}

output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.Name.public_ip
}