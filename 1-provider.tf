# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  credentials = "./todo-gke-132c21df1511.json"
  project = "todo-gke"
  region  = "asia-southeast1"
}


# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "todo-tf-state-staging-1"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
}  


resource "google_storage_bucket" "gcs" {
  name = "todo-tf-state-staging-1"
  location = "asia-southeast1"

  uniform_bucket_level_access = true

  
}
