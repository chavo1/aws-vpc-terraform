# variables.tf
variable "vpc_name" {}
variable "availabilityZone" {}
variable "instanceTenancy" {}
variable "dnsSupport" {}
variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {}
variable "subnetCIDRblock" {}
variable "destinationCIDRblock" {}
variable "ingressCIDRblock" {}
variable "mapPublicIP" {}
# end of variables.tf
