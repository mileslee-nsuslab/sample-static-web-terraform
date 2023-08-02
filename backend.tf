terraform {
  backend "s3" {
    bucket = "miles-terraform-backend"
    key    = "env/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

