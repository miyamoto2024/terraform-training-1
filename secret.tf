resource "google_secret_manager_secret" "terraform-api-key" {
  secret_id = "terraform-api-key"
  labels = {
    label = "terraform"
  }
  replication {
    auto {}
  }
}