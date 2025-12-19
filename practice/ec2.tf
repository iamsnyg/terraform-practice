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
    key_name   = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
    
}

#VPC & security group
resource "aws_default_vpc" "defaultVPC" {

}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_default_vpc.defaultVPC.id

  #inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "automate-sg"
  }
}
# Create ec2 instance
resource "aws_instance" "my_ec2_instance" {
    # count = 2

    for_each = tomap({
        instance-t2micro = "t2.micro"
        instance-t3micro = "t3.micro"
        # instance-t3small = "t3.small"
        # instance-t3medium = "t3.medium"
        
    })

    depends_on = [ aws_key_pair.my_key_pair, aws_security_group.my_security_group ] //ensures key pair and security group are created before instance is created
    # ami = data.aws_ami.ubuntu.id
    ami             = var.ec2_ami_id
    # instance_type   = var.ec2_instance_type
    instance_type   = each.value
    key_name        = aws_key_pair.my_key_pair.key_name
    security_groups = [aws_security_group.my_security_group.name]
    user_data       = file("install-ngnix.sh")
    # vpc_security_group_ids = [aws_security_group.my_security_group.id]

    root_block_device {
        volume_size           = var.env == "prd" ? 9 : var.ec2_default_root_volume_size
        volume_type           = "gp3"
        delete_on_termination = true #delete volume when instance is terminated
    }
    tags = {
        Name = "terraform-ec2-${each.key}"
    }
}

# resource "aws_instance" "my_new_instance" {
#     ami           = "unknown"
#     instance_type = "unknown"
    
# }