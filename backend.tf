terraform {
  backend "remote" {
    organization = "miyamoto2024-terraform"

    workspaces {
      name = "training"
    }
  }
}