variable  "ec2_instance_type" {
    default = "t2.micro"
    type = string
    description = "Type of AWS EC2 instance"
}

variable  "ec2_root_volume_size" {
    default = 8
    type = number
    description = "Size of the root volume in GB"
}

variable "ec2_ami_id" {
    default = "ami-02b8269d5e85954ef" // ami for ubuntu 20.04 in ap-south-1 region
    type = string
    description = "AMI ID for the EC2 instance"
}