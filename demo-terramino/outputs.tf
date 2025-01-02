# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "app_url" {
  value = "http://${aws_eip.terramino.public_dns}:8080"
}
