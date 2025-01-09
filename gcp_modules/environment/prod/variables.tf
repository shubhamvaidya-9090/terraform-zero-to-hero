variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}
variable "region" {
  description = "The project ID to deploy to"
  type        = string
}

variable "template_annotations" {
  description = "Annotations to the container metadata including VPC Connector and SQL. See [more details](https://cloud.google.com/run/docs/reference/rpc/google.cloud.run.v1#revisiontemplate)"
  type        = map(string)
}

variable "service_account_email" {
  description = "Service Account email needed for the service"
  type        = string
  default     = ""
}

variable "volumes" {
  description = "[Beta] Volumes needed for environment variables (when using secret)"
  type = list(object({
    name = string
    secret = set(object({
      secret_name = string
      items       = map(string)
    }))
  }))
  default = []
}

variable "location" {
  description = "Cloud Run service deployment location"
  type        = string
}

variable "service_labels" {
  description = "A set of key/value label pairs to assign to the service"
  type        = map(string)
}

variable "requests" {
  description = "Resource requests to the container"
  type        = map(string)
  default     = {}
}

variable "ports" {
  description = "Port which the container listens to (http1 or h2c)"
  type = object({
    name = string
    port = number
  })
  default = {
    "name" : "http1",
    "port" : 8080
  }
}

variable "container_command" {
  description = "Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten"
  type        = list(string)
  default     = []
}

variable "service_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
}

variable "image" {
  description = "GCR hosted image URL to deploy"
  type        = string
}

variable "env_vars" {
  description = "Environment variables (cleartext)"
  type = list(object({
    value = string
    name  = string
  }))
  default = []
}

variable "force_override" {
  description = "Option to force override existing mapping"
  type        = bool
  default     = false
}

variable "argument" {
  description = "Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments"
  type        = list(string)
  default     = []
}

variable "domain_map_labels" {
  description = "A set of key/value label pairs to assign to the Domain mapping"
  type        = map(string)
  default     = {}
}

variable "domain_map_annotations" {
  description = "Annotations to the domain map"
  type        = map(string)
  default     = {}
}

variable "limits" {
  description = "Resource limits to the container"
  type        = map(string)
  default     = null
}

variable "startup_probe" {
  description = "Startup probe of application within the container. All other probes are disabled if a startup probe is provided, until it succeeds. Container will not be added to service endpoints if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"

  type = object({
    failure_threshold     = optional(number, null)
    initial_delay_seconds = optional(number, null)
    timeout_seconds       = optional(number, null)
    period_seconds        = optional(number, null)
    http_get = optional(object({
      path = optional(string)
      http_headers = optional(list(object({
        name  = string
        value = string
      })), null)
    }), null)
    tcp_socket = optional(object({
      port = optional(number)
    }), null)
    grpc = optional(object({
      port    = optional(number)
      service = optional(string)
    }), null)
  })
  default = null
}

variable "env_secret_vars" {
  description = "[Beta] Environment variables (Secret Manager)"
  type = list(object({
    name = string
    value_from = set(object({
      secret_key_ref = map(string)
    }))
  }))
  default = []
}

variable "members" {
  description = "Users/SAs to be given invoker access to the service"
  type        = list(string)
  default     = []
}

variable "service_annotations" {
  description = "Annotations to the service. Acceptable values all, internal, internal-and-cloud-load-balancing"
  type        = map(string)
  default = {
    "run.googleapis.com/ingress" : "internal-and-cloud-load-balancing"
  }
}

variable "template_labels" {
  description = "A set of key/value label pairs to assign to the container metadata"
  type        = map(string)
  default     = {}
}

variable "encryption_key" {
  description = "CMEK encryption key self-link expected in the format projects/PROJECT/locations/LOCATION/keyRings/KEY-RING/cryptoKeys/CRYPTO-KEY."
  type        = string
  default     = null
}

variable "container_concurrency" {
  description = "Concurrent request limits to the service"
  type        = number
  default     = null
}

variable "timeout_seconds" {
  description = "Timeout for each request"
  type        = number
  default     = 120
}

variable "generate_revision_name" {
  description = "Option to enable revision name generation"
  type        = bool
  default     = true
}

variable "traffic_split" {
  description = "Managing traffic routing to the service"
  type = list(object({
    latest_revision = bool
    percent         = number
    revision_name   = string
    tag             = string
  }))
  default = [
    {
      "latest_revision" : true,
      "percent" : 100,
      "revision_name" : "v1-0-0",
      "tag" : null
    }
  ]
}

variable "verified_domain_name" {
  description = "List of Custom Domain Name"
  type        = list(string)
  default     = []
}

variable "liveness_probe" {
  description = "Periodic probe of container liveness. Container will be restarted if the probe fails. More info : https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
  type = object({
    failure_threshold     = optional(number, null)
    initial_delay_seconds = optional(number, null)
    timeout_seconds       = optional(number, null)
    period_seconds        = optional(number, null)
    http_get = optional(object({
      path = optional(string)
      http_headers = optional(list(object({
        name  = string
        value = string
      })), null)
    }), null)
    grpc = optional(object({
      port    = optional(number)
      service = optional(string)
    }), null)
  })
  default = null
}

variable "volume_mounts" {
  description = "[Beta] Volume Mounts to be attached to the container (when using secret)"
  type = list(object({
    mount_path = string
    name       = string
  }))
  default = [
  ]
}

variable "certificate_mode" {
  description = "The mode of the certificate (NONE or AUTOMATIC)"
  type        = string
  default     = "AUTOMATIC"
}
