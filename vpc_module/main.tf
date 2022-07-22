resource "aws_vpc" "default" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "default"
    }
}

resource "aws_vpc_ipam" "default" {
  operating_regions {
    region_name = var.region
  }
}

resource "aws_vpc_ipam_pool" "default" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.default.private_default_scope_id
  locale         = var.region
}

resource "aws_vpc_ipam_pool_cidr" "default" {
  ipam_pool_id = aws_vpc_ipam_pool.default.id
  cidr         = "10.0.0.0/16"
}
