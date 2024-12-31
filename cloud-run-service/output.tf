output "cloud_run_url" {
  description = "The URL of the deployed Cloud Run service."
  value       = google_cloud_run_service.default.status[0].url
}

output "cloud_run_name" {
  description = "The name of the deployed Cloud Run service."
  value       = google_cloud_run_service.default.name
}
