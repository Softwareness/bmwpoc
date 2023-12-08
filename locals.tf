locals {
  name = "${var.environment}-${var.app_name}"

  tags = {
    "Environment" = var.environment
    "Provisioner" = "terraform"
    "App Name"    = var.app_name
    "App-ID"      = var.app_id
    "Test"        = "bla"
  }
}
