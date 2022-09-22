resource "aws_vpc" "pf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment_name}-vpc"
  }
}
