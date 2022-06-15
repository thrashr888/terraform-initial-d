variable "bucket_name" {
  default = "drift-bucket"
}

variable "bucket_prefix" {
  default = "this-default-wont-work-for-you"
}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
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
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}
