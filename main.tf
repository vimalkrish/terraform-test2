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

# Internet Gateway

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.mod.id}"

  tags {
    Name = "${var.name}-IGW"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#NAT Gateway
resource "aws_eip" "gw_eip_prod_private-1a" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "gw_eip_prod_private-1b" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "gw_eip_uat_private" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_nat_gateway" "nat_gateway_prod_private-1a" {
  allocation_id = "${aws_eip.gw_eip_prod_private-1a.id}"
  subnet_id     = "${aws_subnet.prod-public-primary-1a.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway_prod_private-1b" {
  allocation_id = "${aws_eip.gw_eip_prod_private-1b.id}"
  subnet_id     = "${aws_subnet.prod-public-secondary-1b.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_nat_gateway" "nat_gateway_uat_private" {
  allocation_id = "${aws_eip.gw_eip_uat_private.id}"
  subnet_id     = "${aws_subnet.uat-public-primary-1a.id}"
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

  map_public_ip_on_launch = false

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

  map_public_ip_on_launch = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "corp-private-primary-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.corp-private-primary-1a}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "corp-private-primary-1a"
  }

  map_public_ip_on_launch = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "corp-private-secondary-1b" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.corp-private-secondary-1b}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "corp-private-secondary-1b"
  }

  map_public_ip_on_launch = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "uat-private-primary-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.uat-private-primary-1a}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "uat-private-primary-1a"
  }

  map_public_ip_on_launch = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "uat-private-secondary-1b" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.uat-private-secondary-1b}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "uat-private-secondary-1b"
  }

  map_public_ip_on_launch = false

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

resource "aws_subnet" "corp-public-hubzuprod-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.corp-public-hubzuprod-1a}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "corp-public-hubzuprod-1a"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "uat-public-primary-1a" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.uat-public-primary-1a}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "uat-public-primary-1a"
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "uat-public-secondary-1b" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.uat-public-secondary-1b}"
  availability_zone = "${var.az-1b}"

  tags {
    Name = "uat-public-secondary-1b"
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

resource "aws_route_table_association" "prod-public-primary-1a" {
  subnet_id      = "${aws_subnet.prod-public-primary-1a.id}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "prod-public-secondary-1b" {
  subnet_id      = "${aws_subnet.prod-public-secondary-1b.id}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "corp-public-hubzuprod-1a" {
  subnet_id      = "${aws_subnet.corp-public-hubzuprod-1a.id}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "uat-public-primary-1a" {
  subnet_id      = "${aws_subnet.uat-public-primary-1a.id}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "uat-public-secondary-1b" {
  subnet_id      = "${aws_subnet.uat-public-secondary-1b.id}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}
# Routing table for private subnets

resource "aws_route_table" "private-1a" {
  vpc_id = "${aws_vpc.mod.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_prod_private-1a.id}"
  }

  tags {
    Name = "${var.name}-private-1a"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private-1b" {
  vpc_id = "${aws_vpc.mod.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_prod_private-1b.id}"
  }

  tags {
    Name = "${var.name}-private-1b"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "uat-private" {
  vpc_id = "${aws_vpc.mod.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_uat_private.id}"
  }

  tags {
    Name = "${var.name}-uat-private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "prod-private-primary-1a" {
  subnet_id      = "${aws_subnet.prod-private-primary-1a.id}"
  route_table_id = "${aws_route_table.private-1a.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "prod-private-secondary-1b" {
  subnet_id      = "${aws_subnet.prod-private-secondary-1b.id}"
  route_table_id = "${aws_route_table.private-1b.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "uat-private-primary-1a" {
  subnet_id      = "${aws_subnet.uat-private-primary-1a.id}"
  route_table_id = "${aws_route_table.uat-private.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "uat-private-secondary-1b" {
  subnet_id      = "${aws_subnet.uat-private-secondary-1b.id}"
  route_table_id = "${aws_route_table.uat-private.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "corp-private-primary-1a" {
  subnet_id      = "${aws_subnet.corp-private-primary-1a.id}"
  route_table_id = "${aws_route_table.private-1a.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "corp-private-secondary-1b" {
  subnet_id      = "${aws_subnet.corp-private-secondary-1b.id}"
  route_table_id = "${aws_route_table.private-1b.id}"

  lifecycle {
    create_before_destroy = true
  }
}
