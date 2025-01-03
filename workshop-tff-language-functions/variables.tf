# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "aws_region" {
  description = "The AWS region to deploy your instance"
  default     = "us-east-1"
}

variable "prefix" {
  description = "Prefix for tags"
  default     = "academy"
}

variable "name" {
  description = "The user creating this infrastructure"
  default     = "melvin"
}

variable "department" {
  description = "The organization the user belongs to: dev, prod, qa"
  default     = "dev"
}