# Terraform Module for GCP Cloud Run

This module deploys a Cloud Run service on GCP.

## Inputs

| Variable          | Description                                 | Type   | Default       |
|--------------------|---------------------------------------------|--------|---------------|
| project_id         | The ID of the GCP project.                 | string | -             |
| region             | The GCP region for the service.            | string | "us-central1" |
| service_name       | The name of the Cloud Run service.         | string | -             |
| container_image    | The container image to deploy.             | string | -             |
| cpu                | CPU limit for the service.                 | string | "1"           |
| memory             | Memory limit for the service.              | string | "256Mi"       |
| environment        | Environment variable for the service.      | string | "production"  |
| ingress_setting    | Ingress settings for the service.          | string | "all"         |
| invoker_identity   | Identity that can invoke the service.      | string | -             |
| credentials_file   | Path to the GCP credentials JSON file.     | string | -             |

## Outputs

| Output         | Description                              |
|-----------------|------------------------------------------|
| cloud_run_url  | The URL of the deployed Cloud Run service. |
| cloud_run_name | The name of the deployed Cloud Run service. |

## Usage

```hcl
module "cloud_run" {
  source           = "./modules/cloud_storage"
  project_id       = "your-project-id"
  region           = "us-central1"
  service_name     = "example-service"
  container_image  = "gcr.io/your-project/image:tag"
  credentials_file = "path/to/credentials.json"
  invoker_identity = "serviceAccount:your-invoker@your-project.iam.gserviceaccount.com"
}
