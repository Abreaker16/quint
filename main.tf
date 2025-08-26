terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "google_cloud_run_service" "default" {
  name     = "my-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Value is "us-central1"
output "location_from_id" {
  value = provider::google::location_from_id(google_cloud_run_service.default.id)
}
