# Ref: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/examples/simple_autopilot_public
# To define that we will use GCP
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.80.0" // Provider version
    }
  }
  required_version = "1.13.2" // Terraform version
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone = var.zone
}

resource "google_container_cluster" "my_gke" {
  name                      = "${var.project_id}-gke-cluster"
  location                  = var.region
  remove_default_node_pool  = true
  initial_node_count        = 1
  node_locations            = [var.zone]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "primary-node-pool"
  location   = var.region
  cluster    = google_container_cluster.my_gke.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-standard-4"  
  }
}