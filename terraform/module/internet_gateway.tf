# Internet Gateway
resource "aws_internet_gateway" "pf_internet_gateway" {
  vpc_id = resource.aws_vpc.pf_vpc.id

  tags = {
    Name = "${var.environment_name}_pf_internet_gateway"
  }
}
