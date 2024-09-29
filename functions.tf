resource "google_cloudfunctions2_function" "function" {
  count = 10
  name = "function-test-${count.index}"
  location = "asia-northeast1"
  description = "a new function"

  build_config {
    runtime = "go119"
    entry_point = "HelloHTTP"
    source {
      storage_source {
        bucket = "training-for-terraform-operator"
        object = "function-source.zip"
      }
    }
  }

  service_config {
    min_instance_count  = 0
    max_instance_count  = 1
    timeout_seconds     = 60
  }
}

resource "google_cloudfunctions2_function_iam_member" "invoker" {
  count         = 10
  project        = google_cloudfunctions2_function.function[count.index].project
  location       = google_cloudfunctions2_function.function[count.index].location
  cloud_function = google_cloudfunctions2_function.function[count.index].name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}

resource "google_cloud_run_service_iam_member" "cloud_run_invoker" {
  count         = 10
  project  = google_cloudfunctions2_function.function[count.index].project
  location = google_cloudfunctions2_function.function[count.index].location
  service  = google_cloudfunctions2_function.function[count.index].name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
