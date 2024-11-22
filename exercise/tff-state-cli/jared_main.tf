
resource "aws_vpc" "jared_web_instance" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "Production"
  }
}

resource "aws_subnet" "jared_web_instance" {
  vpc_id     = aws_vpc.jared_web_instance.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "jared_web_instance" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.jared_web_instance.id

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

resource "aws_internet_gateway" "jared_web_instance" {
  vpc_id = aws_vpc.jared_web_instance.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "jared_web_instance" {
  vpc_id = aws_vpc.jared_web_instance.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jared_web_instance.id
  }
}

resource "aws_route_table_association" "jared_web_instance" {
  subnet_id      = aws_subnet.jared_web_instance.id
  route_table_id = aws_route_table.jared_web_instance.id
}

resource "aws_eip" "jared_web_instance" {
  instance = aws_instance.jared_web_instance.id
  vpc      = true
}

resource "aws_eip_association" "jared_web_instance" {
  instance_id   = aws_instance.jared_web_instance.id
  allocation_id = aws_eip.jared_web_instance.id
}

locals {
  jared_web_instance_bootstrap_values = {
    PLACEHOLDER = var.placeholder,
    WIDTH       = var.width,
    HEIGHT      = var.height,
    PREFIX      = var.prefix,
  }
}

resource "aws_instance" "jared_web_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.jared_web_instance.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.jared_web_instance.id
  vpc_security_group_ids      = [aws_security_group.jared_web_instance.id]

  user_data = templatefile("./bootstrap", local.jared_web_instance_bootstrap_values)

  tags = {
    Name = "${var.prefix}-jared_web_instance-instance"
  }
}

resource "tls_private_key" "jared_web_instance" {
  algorithm = "ED25519"
}

locals {
  jared_web_instance_private_key_filename = "${var.prefix}-ssh-key.pem"
}

resource "aws_key_pair" "jared_web_instance" {
  key_name   = local.jared_web_instance_private_key_filename
  public_key = tls_private_key.jared_web_instance.public_key_openssh
}