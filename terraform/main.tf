terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("gcp.json")
  project     = "" // TODO: 外部化
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "tf-network"
  auto_create_subnetworks = false
}
