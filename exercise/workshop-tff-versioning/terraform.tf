terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.0"
    }
  }
}

provider "tls" {
  # Configuration options
}

provider "aws" {
  region = var.region
}

provider "random" {

}
