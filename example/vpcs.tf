module "vpc_virginia" {
  source = "github.com/chavo1/aws-vpc-terraform"

  region               = var.region[0]
  vpc_name             = var.vpc_name[0]
  subnetCIDRblock      = var.subnetCIDRblock[0]
  ingressCIDRblock     = var.ingressCIDRblock
  instanceTenancy      = var.instanceTenancy
  dnsSupport           = var.dnsSupport
  vpcCIDRblock         = var.vpcCIDRblock[0]
  destinationCIDRblock = var.destinationCIDRblock
  availabilityZone     = var.availabilityZone[0]
  mapPublicIP          = var.mapPublicIP
}

module "vpc_ohio" {
  source = "github.com/chavo1/aws-vpc-terraform"

  region               = var.region[1]
  vpc_name             = var.vpc_name[1]
  subnetCIDRblock      = var.subnetCIDRblock[1]
  ingressCIDRblock     = var.ingressCIDRblock
  instanceTenancy      = var.instanceTenancy
  dnsSupport           = var.dnsSupport
  vpcCIDRblock         = var.vpcCIDRblock[1]
  destinationCIDRblock = var.destinationCIDRblock
  availabilityZone     = var.availabilityZone[1]
  mapPublicIP          = var.mapPublicIP

}