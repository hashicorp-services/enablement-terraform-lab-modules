# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }

  required_version = "~> 1.2"
}

provider "aws" {
  region = var.region
}
