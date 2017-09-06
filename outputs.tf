output "prod-private-primary-1a" {
  value = ["${aws_subnet.prod-private-primary-1a.id}"]
}

output "prod-private-secondary-1b" {
  value = ["${aws_subnet.prod-private-secondary-1b.id}"]
}

output "prod-public-primary-1a" {
  value = ["${aws_subnet.prod-private-secondary-1b.id}"]
}

output "prod-public-secondary-1b" {
  value = ["${aws_subnet.prod-private-secondary-1b.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "Hubzu-prod-public" {
  value = "${aws_route_table.Hubzu-prod-public.id}"
}

output "Hubzu-prod-private-1a" {
  value = "${aws_route_table.Hubzu-prod-private-1a.id}"
}

output "Hubzu-prod-private-1b" {
  value = "${aws_route_table.Hubzu-prod-private-1b.id}"
}
