# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "protocol" {
  value = "http://"
}

output "public_dns" {
  value = aws_eip.terramino.public_dns
}

output "port" {
  value = "8080"
}

