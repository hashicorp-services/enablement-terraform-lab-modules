resource "aws_vpc" "demo_test" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "Production"
  }
}

resource "aws_subnet" "demo_test" {
  vpc_id     = aws_vpc.demo_test.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "demo_test" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.demo_test.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_internet_gateway" "demo_test" {
  vpc_id = aws_vpc.demo_test.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "demo_test" {
  vpc_id = aws_vpc.demo_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_test.id
  }
}

resource "aws_route_table_association" "demo_test" {
  subnet_id      = aws_subnet.demo_test.id
  route_table_id = aws_route_table.demo_test.id
}

resource "aws_eip" "demo_test" {
  instance = aws_instance.demo_test.id
  vpc      = true
}

resource "aws_eip_association" "demo_test" {
  instance_id   = aws_instance.demo_test.id
  allocation_id = aws_eip.demo_test.id
}

locals {
  demo_test_bootstrap_values = {
    PLACEHOLDER = var.placeholder,
    WIDTH       = var.width,
    HEIGHT      = var.height,
    PREFIX      = var.prefix,
  }
}

resource "aws_instance" "demo_test" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo_test.id
  vpc_security_group_ids      = [aws_security_group.demo_test.id]

  user_data = templatefile("./bootstrap", local.demo_test_bootstrap_values)

  tags = {
    Name = "${var.prefix}-demo_test-instance"
  }
}