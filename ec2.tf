# key-value pair (login to ec2 instance)
resource "aws_key_pair" "my_key_pair" {
    key_name = "terra-keygen-ec2-keyValuePair"
    public_key = file("terra-keygen-ec2-keyValuePair.pub")
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
    key_name = aws_key_pair.my_key_pair.key_name
    security_groups = [aws_security_group.my_security_group.name]
    ami = "ami-02b8269d5e85954ef" #Ubuntu 20.04
    instance_type = "t2.micro"

    root_block_device {
        volume_size = 8
        volume_type = "gp3"
        delete_on_termination = true #delete volume when instance is terminated
    }
    tags = {
        Name = "automate-ec2-instance"
    }
}