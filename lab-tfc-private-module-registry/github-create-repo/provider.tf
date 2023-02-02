terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.16.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = var.pat
}
