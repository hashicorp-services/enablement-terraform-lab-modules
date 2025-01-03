# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "web_public_address" {
  value = "http://${aws_eip.eip_public.public_ip}:8080"
}

output "user" {
  value = var.name
}

output "department" {
  value = var.department
}
