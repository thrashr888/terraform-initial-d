variable "bucket_name" {
  default = "drift-bucket"
}

variable "bucket_prefix" {
  default = "this-default-wont-work-for-you"
}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  bucket_prefix = var.bucket_prefix

  acl                 = "private"
  object_lock_enabled = false

  versioning {
    enabled = false
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
