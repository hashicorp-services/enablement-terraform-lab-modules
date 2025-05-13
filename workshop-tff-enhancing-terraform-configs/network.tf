# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "aws_vpc" "terramino" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    name        = "dev-vpc-us-east-1"
    environment = "Production"
  }
}

resource "aws_subnet" "terramino" {
  vpc_id     = aws_vpc.terramino.id
  cidr_block = "10.0.10.0/24"

  tags = {
    name = "dev-subnet"
  }
}

resource "aws_security_group" "terramino" {
  name = "dev-security-group"

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
    Name = "dev-security-group"
  }
}

resource "aws_internet_gateway" "terramino" {
  vpc_id = aws_vpc.terramino.id

  tags = {
    Name = "dev-internet-gateway"
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