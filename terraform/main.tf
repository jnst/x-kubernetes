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
  project     = var.PROJECT_ID
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_compute_network" "network" {
  name                    = "tf-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "tf-subnetwork"
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "firewall_internal" {
  name      = "tf-firewall-internal"
  network   = google_compute_network.network.id
  direction = "INGRESS"

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
}

resource "google_compute_firewall" "firewall_external" {
  name      = "tf-firewall-external"
  network   = google_compute_network.network.id
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
