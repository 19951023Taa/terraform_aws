###  public_rt  ###
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-public-rt"
  }
}

resource "aws_route" "public_rt" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_rt_1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_rt_1c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1c.id
}


###  private_rt  ###
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_rt_1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_1c.id
}