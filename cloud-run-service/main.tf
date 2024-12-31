resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = var.ingress_setting
    }
  }

  template {
    spec {
      containers {
        image = var.container_image

        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }

        env {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "noauth" {
  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  members  = ["allUsers"]  # Allows unauthenticated access
}
