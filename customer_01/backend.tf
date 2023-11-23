terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-ferry"
    key            = "customer_01/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

