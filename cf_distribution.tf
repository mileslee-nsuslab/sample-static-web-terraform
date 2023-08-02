resource "aws_cloudfront_distribution" "front_dev_cf_distribution" {
  origin {
    domain_name              = local.bucket_endpoint
    origin_id                = local.bucket_endpoint

    // Required when domain_name refers S3 website endpoint
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "This is DEMO distribution"

  aliases = ["${var.domain_name}"]


  default_cache_behavior {
    # Using the CachingOptimized managed policy ID:
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.bucket_endpoint

    compress = true

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    
  }

  price_class = "PriceClass_All"

  tags = {
    env = "dev"
  }

  viewer_certificate {
    acm_certificate_arn  =  aws_acm_certificate.demo_cert.arn
    // Required specify acm_certificate_arn
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# resource "aws_cloudfront_cache_policy" "frontend_dev_cf_cache_policy" {
#   name        = "CachingOptimized"
#   comment     = "Policy with caching enabled. Supports Gzip and Brotli compression."
#   default_ttl = 86400
#   max_ttl     = 31536000
#   min_ttl     = 1
#   parameters_in_cache_key_and_forwarded_to_origin {
#     cookies_config {
#       cookie_behavior = "none"
#     }
#     headers_config {
#       header_behavior = "none"
#     }
#     query_strings_config {
#       query_string_behavior = "none"
#     }
#   }
# }