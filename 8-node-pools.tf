# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "amd64_pool" {
  name       = "amd64-pool"
  cluster    = google_container_cluster.todo-gke.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-standard-2"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    image_type = "COS_CONTAINERD"

    labels = {
      role = "general"
      node-architecture = "amd64"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "arm64_pool" {
  name       = "arm64-pool"
  cluster    = google_container_cluster.todo-gke.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "t2a-standard-2"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    image_type = "COS_CONTAINERD"

    labels = {
      role = "general"
      node-architecture = "arm64"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
