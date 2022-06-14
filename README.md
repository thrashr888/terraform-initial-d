# drift-bucket
An S3 bucket you can drift in terraform.

```tf
variable "bucket_name" {
  default = "drift-bucket"
}

variable "bucket_prefix" {
  default = "this-default-wont-work-for-you"
}
```
