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
  location               = var.location
  service_labels         = var.service_labels
  image                  = var.image
  service_name           = var.service_name
  domain_map_labels     = var.domain_map_labels
  template_labels       = var.template_labels
  # MCD Overrides
}