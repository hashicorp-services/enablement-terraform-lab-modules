# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: Apache-2.0

# Outputs file
output "catapp_url" {
  value = "http://${google_compute_instance.hashicat.network_interface.0.network_ip}"
}

output "catapp_ip" {
  value = "http://${google_compute_instance.hashicat.network_interface.0.network_ip}"
}
