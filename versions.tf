terraform {
  # Require Terraform version 1.0 (recommended)
  required_version = "~> 1.0"

  # Require the latest 2.x version of the Google provider
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}