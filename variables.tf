variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS region to deploy resources"
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

variable "backend_s3_bucket" {
  type = string
}