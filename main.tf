terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "bucket_prefix" {
  default = "drift-bucket"
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = var.bucket_prefix

  object_lock_enabled = false

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
  lifecycle {
    postcondition {
      condition = self.acl == "private"
      error_message = "This bucket should stay private but it's been changed."
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    postcondition {
      condition = self.versioning_configuration[0].status == "Enabled"
      error_message = "This bucket should stay versioned but it's been changed."
    }
  }
}

output "bucket_name" {
  value = aws_s3_bucket.b.bucket_domain_name
}

output "region_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}
