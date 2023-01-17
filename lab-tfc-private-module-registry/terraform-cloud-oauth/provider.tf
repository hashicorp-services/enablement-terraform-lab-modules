terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.36.1"
    }
  }
}

provider "tfe" {
  # Configuration options
  hostname  = var.hostname
}
