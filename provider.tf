provider "google" {
  credentials = file(var.credential)
  project     = var.project_name
  region      = var.region
}
