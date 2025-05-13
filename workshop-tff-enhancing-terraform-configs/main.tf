# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "aws_instance" "terramino" {
  ami                         = "ami-0718b4ac01274c8cb"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.terramino.id
  vpc_security_group_ids      = [aws_security_group.terramino.id]

  user_data = templatefile("./bootstrap.tftpl")

  tags = {
    Name = "dev-terramino-instance"
  }
}