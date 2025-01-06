# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

locals {
  bootstrap_values = {
    department = var.department,
    name       = var.name,
  }
}

resource "aws_instance" "terramino" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.terramino.id
  vpc_security_group_ids      = [aws_security_group.terramino.id]

  user_data = templatefile("./bootstrap.tftpl", local.bootstrap_values)

  tags = {
    Name = "${var.prefix}-terramino-instance"
  }
}