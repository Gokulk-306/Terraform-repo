output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.ec2_server.instance_id
}

output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = module.ec2_server.public_ip
}

