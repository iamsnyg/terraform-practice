output "ec2_public_ip" {
    description = "The public IP address of the EC2 instance"
    value = aws_instance.my_ec2_instance.public_ip
}

output "ec2_public_dns" {
    description = "The public DNS of the EC2 instance"
    value = aws_instance.my_ec2_instance.public_dns
}

output "ec2_private_ip" {
    description = "The private IP address of the EC2 instance"
    value = aws_instance.my_ec2_instance.private_ip
}
output "ec2_instance_id" {
    description = "The ID of the EC2 instance"
    value = aws_instance.my_ec2_instance.id
}