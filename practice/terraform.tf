terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }

  backend "s3" {
    bucket = "remote-infra-bucket-6497"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "GameScores"
    # encrypt = true
  }
}
