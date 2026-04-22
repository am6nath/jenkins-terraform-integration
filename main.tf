terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2" # Hyderabad
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "amarnath17"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0aa31b568c1e8d622" # Amazon Linux 2023 (x86_64) in ap-south-2
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "MCA-EC2-Key"           # Your key pair for SSH access
}
