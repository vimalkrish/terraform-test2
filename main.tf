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
  subnet_id     = "${aws_subnet.public.0.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  lifecycle {
    create_before_destroy = true
  }
}

# Public subnets

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_subnets)}"

  tags {
    Name = "${var.name}-public"
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

# Private subsets

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name = "${var.name}-private"
  }

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
