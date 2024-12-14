provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.service_account)
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.10.0"
    }
  }
}