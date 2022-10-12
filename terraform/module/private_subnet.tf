# Private Subnet1
resource "aws_subnet" "pf_private_subnet_1" {
  vpc_id                  = resource.aws_vpc.pf_vpc.id
  cidr_block              = var.prv_sub1_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment_name}_pf_private_subnet_1"
  }
}

# Private Subnet2
resource "aws_subnet" "pf_private_subnet_2" {
  vpc_id                  = resource.aws_vpc.pf_vpc.id
  cidr_block              = var.prv_sub2_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment_name}_pf_private_subnet_2"
  }
}


resource "aws_db_subnet_group" "pf_private_db_subnet_group" {
  name       = "${var.environment_name}_private_db_subnet_group"
  subnet_ids = [aws_subnet.pf_private_subnet_1.id, aws_subnet.pf_private_subnet_2.id]
}
