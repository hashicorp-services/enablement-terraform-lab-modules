terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.42.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}

provider "tls" {
  # Configuration options
}

provider "aws" {
  region = var.region
}
