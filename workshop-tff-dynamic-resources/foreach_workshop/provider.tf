terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "=3.68.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "random" {}
