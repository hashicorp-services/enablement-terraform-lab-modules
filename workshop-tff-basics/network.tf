# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "aws_vpc" "terramino" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "Production"
  }
}

resource "aws_subnet" "terramino" {
  vpc_id     = aws_vpc.terramino.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "terramino" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.terramino.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "terramino" {
  vpc_id = aws_vpc.terramino.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "terramino" {
  vpc_id = aws_vpc.terramino.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terramino.id
  }
}

resource "aws_route_table_association" "terramino" {
  subnet_id      = aws_subnet.terramino.id
  route_table_id = aws_route_table.terramino.id
}

resource "aws_eip" "terramino" {
  instance = aws_instance.terramino.id
  domain   = "vpc"
}

resource "aws_eip_association" "terramino" {
  instance_id   = aws_instance.terramino.id
  allocation_id = aws_eip.terramino.id
}