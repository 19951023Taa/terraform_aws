resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.project}-${var.env}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.project}-${var.env}-public-subnet-1c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${var.project}-${var.env}-private-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${var.project}-${var.env}-private-subnet-1c"
  }
}