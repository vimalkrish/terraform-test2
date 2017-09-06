resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# NAT Gateway

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.mod.id}"

  tags {
    Name = "${var.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "gw_eip" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.gw_eip.id}"
  subnet_id     = "${aws_subnet.prod-public-primary-1a.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  lifecycle {
    create_before_destroy = true
  }
}

# Private subnets

resource "aws_subnet" "prod-private-primary-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.prod-private-primary-1a}"
  availability_zone = "${var.az-1a}"

  tags {
    Name = "prod-private-primary-1a"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "prod-private-secondary-1b" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.prod-private-secondary-1b}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "prod-private-secondary-1b"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

#public

resource "aws_subnet" "prod-public-primary-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.prod-public-primary-1a}"
  availability_zone = "${var.az-1a}"

  tags {
    Name = "prod-public-primary-1a"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_subnet" "prod-public-secondary-1b" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.prod-public-secondary-1b}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "prod-public-secondary-1b"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

# Routing table for public subnets

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.mod.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "${var.name}-public"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
  count          = "${length(var.public_subnets)}"

  lifecycle {
    create_before_destroy = true
  }
}


# Routing table for private subnets

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.mod.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name = "${var.name}-private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
  count          = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}
