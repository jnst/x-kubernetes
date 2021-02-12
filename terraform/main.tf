terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project     = var.PROJECT_ID
  region      = var.mainly_region
  zone        = var.mainly_zone
}

resource "google_compute_network" "network" {
  name                    = "tf-xk8s-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "tf-xk8s-subnetwork"
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "firewall_internal" {
  name      = "tf-xk8s-firewall-internal"
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
  name      = "tf-xk8s-firewall-external"
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

resource "google_compute_instance" "master_node" {
  for_each                  = local.master_nodes
  name                      = "tf-xk8s-instance-${each.key}"
  machine_type              = "f1-micro"
  zone                      = var.mainly_zone
  tags                      = ["xk8s", "master"]
  allow_stopping_for_update = true
  scheduling {
    preemptible       = each.value
    automatic_restart = false
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = google_compute_network.network.id
  }
}

resource "google_compute_instance" "worker_node" {
  for_each                  = local.worker_nodes
  name                      = "tf-xk8s-instance-${each.key}"
  machine_type              = "f1-micro"
  zone                      = var.mainly_zone
  tags                      = ["xk8s", "worker"]
  allow_stopping_for_update = true
  scheduling {
    preemptible       = each.value
    automatic_restart = false
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = google_compute_network.network.id
  }
}
