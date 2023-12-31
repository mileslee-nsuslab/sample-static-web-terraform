resource "aws_cloudfront_distribution" "front_dev_cf_distribution_non_www" {
  origin {
    domain_name              = local.non_www_bucket_endpoint
    origin_id                = local.non_www_bucket_endpoint

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
  comment             = "This is for non-www version S3 distribution"

  aliases = ["${var.root_domain_name}"]


  default_cache_behavior {
    # Using the CachingOptimized managed policy ID:
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.non_www_bucket_endpoint

    compress = true

    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 3600
    # max_ttl                = 86400
    
  }

  price_class = "PriceClass_All"

  tags = {
    env = "dev"
  }

  viewer_certificate {
    acm_certificate_arn  =  aws_acm_certificate.root_cert.arn
    // Required specify acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
