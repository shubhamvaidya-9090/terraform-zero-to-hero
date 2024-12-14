variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "source_bucket" {
  description = "Source bucket name"
  type        = string
}

variable "destination_bucket" {
  description = "Destination bucket name"
  type        = string
}

variable "service_account" {
  type        = string
}