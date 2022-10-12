# Subnet 1
resource "aws_subnet" "pf_public_subnet_1" {
  vpc_id                  = resource.aws_vpc.pf_vpc.id
  cidr_block              = var.pub_sub1_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}_pf_public_subnet_1"
  }
}

# Subnet 2
resource "aws_subnet" "pf_public_subnet_2" {
  vpc_id                  = resource.aws_vpc.pf_vpc.id
  cidr_block              = var.pub_sub2_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}_pf_public_subnet_2"
  }
}