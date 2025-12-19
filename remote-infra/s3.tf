resource "aws_s3_bucket" "s3_remote_infra_bucket" {
  bucket = "remote-infra-bucket-6497"

  tags = {
    Name        = "my-s3-bucket"
    
  }
}