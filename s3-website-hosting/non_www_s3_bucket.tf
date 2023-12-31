// S3 bucket resource
resource "aws_s3_bucket" "frontend_dev_hosting_bucket_blue" {
  bucket = var.bucket_non_www_name
  force_destroy = true

  tags = {
    Environment = "Dev"
  }
}

// S3 bucket website hosting resource
resource "aws_s3_bucket_website_configuration" "frontend_dev_hosting_config_blue" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_blue.id

  redirect_all_requests_to {
    host_name = var.www_domain_name
    protocol = "https"
  }
}

// S3 bucket public policy resource
resource "aws_s3_bucket_public_access_block" "frontend_dev_public_policy_blue" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_blue.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// S3 bucket policy resource
resource "aws_s3_bucket_policy" "frontend_dev_bucket_policy_blue" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_blue.id
  policy = data.aws_iam_policy_document.allow_get_from_public_blue.json
}
