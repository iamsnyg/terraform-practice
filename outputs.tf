// Outputs for multiple EC2 instances created using count

# output "ec2_public_ip" {
#   description = "The public IP address of the EC2 instance"
#   value       = aws_instance.my_ec2_instance[*].public_ip
# }

# output "ec2_public_dns" {
#   description = "The public DNS of the EC2 instance"
#   value       = aws_instance.my_ec2_instance[*].public_dns
# }

# output "ec2_private_ip" {
#   description = "The private IP address of the EC2 instance"
#   value       = aws_instance.my_ec2_instance[*].private_ip
# }
# output "ec2_instance_id" {
#   description = "The ID of the EC2 instance"
#   value       = aws_instance.my_ec2_instance[*].id
# }

// Outputs for multiple EC2 instances created using for_each
output "forEach_ec2_instance_ids" {
  description = "The IDs of all EC2 instances created using for_each"
  value       = [
    for instance in aws_instance.my_ec2_instance : instance.id
  ]
}

output "forEach_ec2_instance_public_ips" {
  description = "The public IPs of all EC2 instances created using for_each"
  value       = [
    for instance in aws_instance.my_ec2_instance : instance.public_ip
  ]
}