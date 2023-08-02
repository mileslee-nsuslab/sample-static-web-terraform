locals {
  bucket_endpoint = aws_s3_bucket_website_configuration.frontend-dev-hosting-config-green.website_endpoint
}