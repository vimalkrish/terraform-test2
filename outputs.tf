output "prod-private-primary-1a" {
  value = ["${aws_subnet.prod-private-primary-1a.id}"]
}

output "prod-private-secondary-1b" {
  value = ["${aws_subnet.prod-private-secondary-1b.id}"]
}

output "prod-public-primary-1a" {
  value = ["${aws_subnet.prod-public-primary-1a.id}"]
}

output "prod-public-secondary-1b" {
  value = ["${aws_subnet.prod-public-secondary-1b.id}"]
}

output "corp-private-primary-1a" {
  value = ["${aws_subnet.corp-private-primary-1a.id}"]
}

output "corp-private-secondary-1b" {
  value = ["${aws_subnet.corp-private-secondary-1b.id}"]
}

output "corp-public-hubzuprod-1a" {
  value = ["${aws_subnet.corp-public-hubzuprod-1a.id}"]
}

output "uat-private-primary-1a" {
  value = ["${aws_subnet.uat-private-primary-1a.id}"]
}

output "uat-private-secondary-1b" {
  value = ["${aws_subnet.uat-private-secondary-1b.id}"]
}

output "uat-public-primary-1a" {
  value = ["${aws_subnet.uat-public-primary-1a.id}"]
}

output "uat-public-secondary-1b" {
  value = ["${aws_subnet.uat-public-secondary-1b.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "public" {
  value = "${aws_route_table.public.id}"
}

output "private-1a" {
  value = "${aws_route_table.private-1a.id}"
}

output "private-1b" {
  value = "${aws_route_table.private-1b.id}"
}

output "uat-private" {
  value = "${aws_route_table.uat-private.id}"
}
