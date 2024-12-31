# Create source bucket
resource "google_storage_bucket" "source" {
  name     = var.source_bucket
  location = var.region
  uniform_bucket_level_access = true
}

# Create destination bucket
resource "google_storage_bucket" "destination" {
  name     = var.destination_bucket
  location = var.region
  uniform_bucket_level_access = true
}
# Fetch google transfer storage service account 
data "google_storage_transfer_project_service_account" "default" {
  project = var.project_id
}

# Output the service agent email
output "storage_transfer_service_agent" {
  value = data.google_storage_transfer_project_service_account.default.email
}

# Grant permissions to source bucket
resource "google_storage_bucket_iam_binding" "source_bucket_binding_objectViewer" {
  bucket = google_storage_bucket.source.name
  role   = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  ]
}

# Grant permissions to source bucket
resource "google_storage_bucket_iam_binding" "source_bucket_binding_legacyBucketWriter" {
  bucket = google_storage_bucket.source.name
  role   = "roles/storage.legacyBucketWriter"
  members = [
    "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  ]
}

# Grant permissions to destination bucket
resource "google_storage_bucket_iam_binding" "destination_bucket_binding_objectViewer" {
  bucket = google_storage_bucket.destination.name
  role   = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  ]
}

# Grant permissions to destination bucket
resource "google_storage_bucket_iam_binding" "destination_bucket_binding_legacyBucketWriter" {
  bucket = google_storage_bucket.destination.name
  role   = "roles/storage.legacyBucketWriter"
  members = [
    "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  ]
}

# Create transfer job
resource "google_storage_transfer_job" "transfer_job" {
  description = "Transfer files between GCP buckets daily"
  project     = var.project_id

  transfer_spec {
    gcs_data_source {
      bucket_name = google_storage_bucket.source.name
    }

    gcs_data_sink {
      bucket_name = google_storage_bucket.destination.name
    }

    transfer_options {
      delete_objects_unique_in_sink = false
      overwrite_objects_already_existing_in_sink = true
    }
  }

  schedule {
    schedule_start_date {
      year  = 2024
      month = 1
      day   = 1
    }
    start_time_of_day {
      hours   = 0
      minutes = 0
      seconds = 0
      nanos   = 0
    }
  }

  depends_on = [
    google_storage_bucket_iam_binding.source_bucket_binding_objectViewer,
    google_storage_bucket_iam_binding.source_bucket_binding_legacyBucketWriter,
    google_storage_bucket_iam_binding.destination_bucket_binding_objectViewer,
    google_storage_bucket_iam_binding.destination_bucket_binding_legacyBucketWriter
  ]
}