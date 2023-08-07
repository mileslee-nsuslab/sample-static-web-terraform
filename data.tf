data "aws_iam_policy_document" "allow_get_from_public_blue" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_non_www_name}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "allow_get_from_public_green" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_www_name}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

# data "aws_iam_policy_document" "only_allow_from_cloudfront" {
#   statement {
#     sid       = "PublicReadGetObject"
#     effect    = "Allow"
#     resources = ["arn:aws:s3:::${var.bucket_www_name}/*"]
#     actions   = ["s3:GetObject"]

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#   }
# }