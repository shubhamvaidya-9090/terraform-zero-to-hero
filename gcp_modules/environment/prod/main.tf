terraform {
  required_version = ">= 1.6.0, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "< 7.0.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

module "cloud-run" {
  # Module source and version
  source = "../../modules/cloud-run-service"

  # Module inputs
  project_id             = var.project_id
  template_annotations   = var.template_annotations
  service_account_email  = var.service_account_email
  volumes                = var.volumes
  location               = var.location
  service_labels         = var.service_labels
  requests               = var.requests
  ports                  = var.ports
  container_command      = var.container_command
  service_name           = var.service_name
  image                  = var.image
  env_vars               = var.env_vars
  force_override         = var.force_override
  argument               = var.argument
  domain_map_labels      = var.domain_map_labels
  domain_map_annotations = var.domain_map_annotations
  limits                 = var.limits
  startup_probe          = var.startup_probe
  env_secret_vars        = var.env_secret_vars
  members                = var.members
  service_annotations    = var.service_annotations
  template_labels        = var.template_labels
  encryption_key         = var.encryption_key
  container_concurrency  = var.container_concurrency
  timeout_seconds        = var.timeout_seconds
  generate_revision_name = var.generate_revision_name
  traffic_split          = var.traffic_split
  verified_domain_name   = var.verified_domain_name
  liveness_probe         = var.liveness_probe
  volume_mounts          = var.volume_mounts
  certificate_mode       = var.certificate_mode

  # MCD Overrides
}