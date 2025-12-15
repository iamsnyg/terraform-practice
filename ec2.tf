# data "aws_ami" "ubuntu" {
#     most_recent = true
#     owners      = ["099720109477"] # Canonical

#     filter {
#         name   = "name"
#         values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#     }
 
#     filter {
#         name   = "virtualization-type"
#         values = ["hvm"]
#     }
# }

# key-value pair (login to ec2 instance)
resource "aws_key_pair" "my_key_pair" {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

#VPC & security group
resource "aws_default_vpc" "defaultVPC" {

}

resource "aws_security_group" "my_security_group" {
    name = "automate-sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_default_vpc.defaultVPC.id

    #inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH access"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP access"
    }
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP access"
    }

    #outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    tags = {
        Name = "automate-sg"
    }
}
# Create ec2 instance
resource "aws_instance" "my_ec2_instance" {
    # ami = data.aws_ami.ubuntu.id
    ami = "ami-02b8269d5e85954ef" #ubuntu 20.04 in us-east-1
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key_pair.key_name
    security_groups = [aws_security_group.my_security_group.name]
    # vpc_security_group_ids = [aws_security_group.my_security_group.id]

    root_block_device {
        volume_size = 8
        volume_type = "gp3"
        delete_on_termination = true #delete volume when instance is terminated
    }
    tags = {
        Name = "automate-ec2-instance"
    }
}

# Output the public IP and DNS of the instance
# output "ec2_public_ip" {
#     description = "The public IP address of the EC2 instance"
#     value = aws_instance.my_ec2_instance.public_ip
# }