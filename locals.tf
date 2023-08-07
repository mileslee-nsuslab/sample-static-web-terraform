locals {
  www_bucket_endpoint = aws_s3_bucket_website_configuration.frontend-dev-hosting-config-green.website_endpoint
  non_www_bucket_endpoint = aws_s3_bucket_website_configuration.frontend-dev-hosting-config-blue.website_endpoint
}