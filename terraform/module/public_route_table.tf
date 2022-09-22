# Public Route table 1
resource "aws_route_table" "pf_route_table" {
  vpc_id = resource.aws_vpc.pf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.pf_internet_gateway.id
  }

  tags = {
    Name = "${var.environment_name}_pf_route_table"
  }
}

# Route table assocciation with subnet
resource "aws_route_table_association" "pf_public_subnet_association_1" {
  route_table_id = resource.aws_route_table.pf_route_table.id
  subnet_id      = resource.aws_subnet.pf_public_subnet_1.id
}

resource "aws_route_table_association" "pf_public_subnet_association_2" {
  route_table_id = resource.aws_route_table.pf_route_table.id
  subnet_id      = resource.aws_subnet.pf_public_subnet_2.id
}
