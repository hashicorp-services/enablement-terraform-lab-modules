variable "project" {
  description = "ID of your GCP project. Make sure you set this up before running this terraform code.  REQUIRED."
}

variable "region" {
  description = "The region where the resources are created."
  default     = "us-central1"
}