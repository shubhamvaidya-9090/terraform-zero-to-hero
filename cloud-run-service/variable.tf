variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "region" {
  description = "The GCP region for the service."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "container_image" {
  description = "The container image to deploy to Cloud Run."
  type        = string
}

variable "cpu" {
  description = "CPU limit for the Cloud Run service."
  type        = string
  default     = "1"
}

variable "memory" {
  description = "Memory limit for the Cloud Run service."
  type        = string
  default     = "256Mi"
}

variable "environment" {
  description = "Environment variable for the service."
  type        = string
  default     = "production"
}

variable "ingress_setting" {
  description = "Ingress settings for the Cloud Run service."
  type        = string
  default     = "all"
}

variable "invoker_identity" {
  description = "Identity (e.g., service account) that can invoke the Cloud Run service."
  type        = string
}

variable "credentials_file" {
  description = "Path to the GCP credentials JSON file."
  type        = string
}
