resource "google_storage_bucket" "functions_bucket" {
  name          = "${var.project_name}-functions-bucket"
  project       = var.project_name
  location      = var.region
  force_destroy = true
}
