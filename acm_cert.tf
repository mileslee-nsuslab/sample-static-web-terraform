resource "aws_acm_certificate" "demo_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    env = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "demo_cert_validation" {
#   certificate_arn         = aws_acm_certificate.demo_cert.arn
#   validation_record_fqdns = [aws_acm_certificate.demo_cert.domain_name]
# }