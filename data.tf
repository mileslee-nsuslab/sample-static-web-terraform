data "aws_iam_policy_document" "allow_get_from_public_blue" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_blue_name}/*"]
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
    resources = ["arn:aws:s3:::${var.bucket_green_name}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}