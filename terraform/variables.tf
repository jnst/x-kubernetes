variable "PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}

variable "GOOGLE_CREDENTIALS" {
  type        = string
  description = "GCP Credentials path or json format text"
}

variable "mainly_region" {
  type        = string
  default     = "us-west1"
  description = "GCP region to be used mainly"
}

variable "mainly_zone" {
  type        = string
  default     = "us-west1-c"
  description = "GCP zone to be used mainly"
}

variable "terraform_cloud_organization" {
  type        = string
  default     = "x-kubernetes"
  description = "Organization name in Terraform Cloud"
}

variable "terraform_cloud_workspace" {
  type        = string
  default     = "x-kubernetes"
  description = "Workspace name in Terraform Cloud"
}

locals {
  master_nodes = {
    master1 = false
    master2 = true
    master3 = true
  }
  worker_nodes = {
    worker1 = false
    worker2 = true
    worker3 = true
  }
}
