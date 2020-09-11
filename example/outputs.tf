output "vpc_virginia_id" {
  value = module.vpc_virginia.vpc
}

output "vpc_ohio_id" {
  value = module.vpc_ohio.vpc
}

output "aws_security_group_virginia" {
  value = module.vpc_virginia.aws_security_group
}

output "aws_security_group_ohio" {
  value = module.vpc_ohio.aws_security_group
}

output "subnet_virginia" {
  value = module.vpc_virginia.subnet
}

output "subnet_ohio" {
  value = module.vpc_ohio.subnet
}

output "rtb_virginia" {
  value = module.vpc_virginia.rtb
}

output "rtb_ohio" {
  value = module.vpc_ohio.rtb
}