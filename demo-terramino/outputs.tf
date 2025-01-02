# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "catapp_url" {
  value = "http://${aws_eip.terramino.public_dns}:8080"
}

output "catapp_ip" {
  value = "http://${aws_eip.terramino.public_ip}:8080"
}