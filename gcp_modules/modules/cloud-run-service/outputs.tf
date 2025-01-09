output "verified_domain_name" {
  description = "List of Custom Domain Name"
  value       = module.cloud_run_service.verified_domain_name
}

output "service_name" {
  description = "Name of the created service"
  value       = module.cloud_run_service.service_name
}

output "revision" {
  description = "Deployed revision for the service"
  value       = module.cloud_run_service.revision
}

output "project_id" {
  description = "Google Cloud project in which the service was created"
  value       = module.cloud_run_service.project_id
}

output "domain_map_id" {
  description = "Unique Identifier for the created domain map"
  value       = module.cloud_run_service.domain_map_id
}

output "domain_map_status" {
  description = "Status of Domain mapping"
  value       = module.cloud_run_service.domain_map_status
}

output "service_url" {
  description = "The URL on which the deployed service is available"
  value       = module.cloud_run_service.service_url
}

output "location" {
  description = "Location in which the Cloud Run service was created"
  value       = module.cloud_run_service.location
}

output "service_id" {
  description = "Unique Identifier for the created service"
  value       = module.cloud_run_service.service_id
}

output "service_status" {
  description = "Status of the created service"
  value       = module.cloud_run_service.service_status
}