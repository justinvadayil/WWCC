# main.tf
provider "aws" {
  region = var.AWS_REGION
}

variable "AWS_REGION" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-terraform-bucket-${var.environment}-${random_string.suffix.result}"
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.example.bucket
  description = "Name of the S3 bucket"
}
