// S3 bucket resource
resource "aws_s3_bucket" "frontend-dev-hosting-bucket-blue" {
  bucket = var.bucket_blue_name
  force_destroy = true

  tags = {
    Environment = "Dev"
  }
}

// S3 bucket website hosting resource
resource "aws_s3_bucket_website_configuration" "frontend-dev-hosting-config-blue" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-blue.id

  index_document {
    suffix = "index.html"
  }
}

// S3 bucket public policy resource
resource "aws_s3_bucket_public_access_block" "frontend-dev-public-policy-blue" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-blue.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// S3 bucket policy resource
resource "aws_s3_bucket_policy" "frontend-dev-bucket-policy-blue" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-blue.id
  policy = data.aws_iam_policy_document.allow_get_from_public_blue.json
}
