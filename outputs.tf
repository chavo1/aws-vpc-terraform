output "aws_security_group" {
  value = "${aws_security_group.vpc_Security_Group.*.id}"
}

output "subnet" {
  value = "${aws_subnet.vpc_subnet.*.id}"
}

output "vpc" {
  value = "${aws_vpc.vpc.*.id}"
}

output "rtb" {
  value = "${aws_route_table.public.*.id}"
}