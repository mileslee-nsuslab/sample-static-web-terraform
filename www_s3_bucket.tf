// S3 bucket resource
resource "aws_s3_bucket" "frontend_dev_hosting_bucket_green" {
  bucket = var.bucket_www_name
  force_destroy = true

  tags = {
    Environment = "Dev"
  }
}

// S3 bucket website hosting resource
resource "aws_s3_bucket_website_configuration" "frontend_dev_hosting_config_green" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_green.id

  index_document {
    suffix = "index.html"
  }
}

// S3 bucket public policy resource
resource "aws_s3_bucket_public_access_block" "frontend_dev_public_policy_green" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_green.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// S3 bucket policy resource
resource "aws_s3_bucket_policy" "frontend_dev_bucket_policy_green" {
  bucket = aws_s3_bucket.frontend_dev_hosting_bucket_green.id
  policy = data.aws_iam_policy_document.allow_get_from_public_green.json
}

# // S3 buckdet Ownership control resource
# resource "aws_s3_bucket_ownership_controls" "frontend-dev-ownership-control-green" {
#   bucket = aws_s3_bucket.frontend-dev-hosting-bucket-green.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# // S3 bucket ACL resource
# resource "aws_s3_bucket_acl" "frontend-dev-bucket-acl-green" {
#   bucket = aws_s3_bucket.frontend-dev-hosting-bucket-green.id

#   acl = "private"

#   // To force ACL resource to create after Ownership control resource
#   depends_on = [aws_s3_bucket_ownership_controls.frontend-dev-ownership-control-green]
# }

