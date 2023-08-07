// S3 bucket resource
resource "aws_s3_bucket" "frontend-dev-hosting-bucket-green" {
  bucket = var.bucket_www_name
  force_destroy = true

  tags = {
    Environment = "Dev"
  }
}

// S3 bucket website hosting resource
resource "aws_s3_bucket_website_configuration" "frontend-dev-hosting-config-green" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-green.id

  index_document {
    suffix = "index.html"
  }
}

// S3 bucket public policy resource
resource "aws_s3_bucket_public_access_block" "frontend-dev-public-policy-green" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-green.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// S3 bucket policy resource
resource "aws_s3_bucket_policy" "frontend-dev-bucket-policy-green" {
  bucket = aws_s3_bucket.frontend-dev-hosting-bucket-green.id
  policy = data.aws_iam_policy_document.allow_get_from_public_green.json
}
