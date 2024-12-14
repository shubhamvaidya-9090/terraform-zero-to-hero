
# # Create Service Account for Storage Transfer
# resource "google_service_account" "storage_transfer" {
#   account_id   = "storage-transfer-sa"
#   display_name = "Storage Transfer Service Account"
#   project      = var.project_id
# }

# # Assign required roles to the service account
# resource "google_project_iam_member" "storage_transfer_iam" {
#   project = var.project_id
#   role    = "roles/storage.admin"
#   member  = "serviceAccount:${google_service_account.storage_transfer.email}"
# }

# data "google_project" "current" {
#   project_id = var.project_id
# }

# locals {
#   storage_transfer_service_account = "${data.google_project.current.number}@storage-transfer-service.iam.gserviceaccount.com"
# }

# # Create source bucket
# resource "google_storage_bucket" "source" {
#   name     = var.source_bucket
#   location = var.region
#   uniform_bucket_level_access = true
# }

# # Create destination bucket
# resource "google_storage_bucket" "destination" {
#   name     = var.destination_bucket
#   location = var.region
#   uniform_bucket_level_access = true
# }

# # Grant permissions to source bucket
# resource "google_storage_bucket_iam_binding" "source_bucket_binding" {
#   bucket = google_storage_bucket.source.name
#   role   = "roles/storage.objectViewer"
#   members = [
#     "serviceAccount:${google_service_account.storage_transfer.email}",
#     "serviceAccount:${local.storage_transfer_service_account}"
#   ]
# }

# # Grant permissions to destination bucket
# resource "google_storage_bucket_iam_binding" "destination_bucket_binding" {
#   bucket = google_storage_bucket.destination.name
#   role   = "roles/storage.admin"
#   members = [
#     "serviceAccount:${google_service_account.storage_transfer.email}",
#     "serviceAccount:${local.storage_transfer_service_account}"
#   ]
# }

# # Create transfer job
# resource "google_storage_transfer_job" "transfer_job" {
#   description = "Transfer files between GCP buckets daily"
#   project     = var.project_id

#   transfer_spec {
#     gcs_data_source {
#       bucket_name = google_storage_bucket.source.name
#     }

#     gcs_data_sink {
#       bucket_name = google_storage_bucket.destination.name
#     }

#     transfer_options {
#       delete_objects_unique_in_sink = false
#       overwrite_objects_already_existing_in_sink = true
#     }
#   }

#   schedule {
#     schedule_start_date {
#       year  = 2024
#       month = 1
#       day   = 1
#     }
#     start_time_of_day {
#       hours   = 0
#       minutes = 0
#       seconds = 0
#       nanos   = 0
#     }
#   }

#   depends_on = [
#     google_storage_bucket_iam_binding.source_bucket_binding,
#     google_storage_bucket_iam_binding.destination_bucket_binding
#   ]
# }
