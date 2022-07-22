# Create a VPC
data "aws_region" "current" {}

module "my_vpc" {
  source = "./vpc_module"

  region = data.aws_region.current.name

}

#resource "aws_vpc" "default" {
#    cidr_block       = "10.0.0.0/16"
#    instance_tenancy = "default"
#    enable_dns_hostnames = true
#
#    tags = {
#        Name = "default"
#    }
#}
#
#resource "aws_vpc_ipam" "default" {
#  operating_regions {
#    region_name = data.aws_region.current.name
#  }
#}
#
#resource "aws_vpc_ipam_pool" "default" {
#  address_family = "ipv4"
#  ipam_scope_id  = aws_vpc_ipam.default.private_default_scope_id
#  locale         = data.aws_region.current.name
#}
#
#resource "aws_vpc_ipam_pool_cidr" "default" {
#  ipam_pool_id = aws_vpc_ipam_pool.default.id
#  cidr         = "10.0.0.0/16"
#}

data "aws_availability_zone" "az_1" {
  name = "${data.aws_region.current.name}b"
}

data "aws_availability_zone" "az_2" {
  name = "${data.aws_region.current.name}c"
}

resource "aws_internet_gateway" "gw" {
#    vpc_id = aws_vpc.default.id
    vpc_id = "${module.my_vpc.aws_vpc_default_id}"
}

resource "aws_subnet" "az_1" {
  vpc_id     =  "${module.my_vpc.aws_vpc_default_id}"
  cidr_block = "10.0.0.0/24"
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_subnet" "az_2" {
  vpc_id     = "${module.my_vpc.aws_vpc_default_id}"
  cidr_block = "10.0.1.0/24"
  depends_on = [aws_internet_gateway.gw]
}
