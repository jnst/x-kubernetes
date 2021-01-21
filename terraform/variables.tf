variable "PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}

variable "GOOGLE_CREDENTIALS" {
  type        = string
  description = "GCP Credentials path or json format text"
}

variable "terraform_cloud_organization" {
  type        = string
  default     = "x-kubernetes"
  description = "Terraform Cloud organization name"
}

variable "terraform_cloud_workspace" {
  type        = string
  default     = "x-kubernetes"
  description = "Terraform Cloud workspace name"
}
