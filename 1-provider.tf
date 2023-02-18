# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "gke-app-376315"
  region  = "asia-southeast1"
}

# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "todo-tf-state-staging"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
