
# Create private route table for prv sub1
# resource "aws_route_table" "pf_private_route_table_1" {
#   vpc_id = resource.aws_vpc.pf_vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = resource.aws_nat_gateway.pf_nat_gateway_1.id
#   }

#   tags = {
#     Name = "${var.environment_name}_pf_private_route_table_1"
#   }
# }

# # Create private route table for prv sub1
# resource "aws_route_table" "pf_private_route_table_2" {
#   vpc_id = resource.aws_vpc.pf_vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = resource.aws_nat_gateway.pf_nat_gateway_2.id
#   }

#   tags = {
#     Name = "${var.environment_name}_pf_private_route_table_2"
#   }
# }

# Create route table association betn prv sub1 & NAT GW1
resource "aws_route_table_association" "pf_private_subnet_association_1" {
  # PARA CONECTAR NAT GATEWAY
  #route_table_id = resource.aws_route_table.pf_private_route_table_1.id

  # BORRAR ####################################################
  route_table_id = resource.aws_route_table.pf_route_table.id
  #############################################################

  subnet_id = resource.aws_subnet.pf_private_subnet_1.id
}

# Create route table association betn prv sub2 & NAT GW2
resource "aws_route_table_association" "pf_private_subnet_association_2" {
  # PARA CONECTAR NAT GATEWAY
  #route_table_id = resource.aws_route_table.pf_private_route_table_2.id

  # BORRAR ####################################################
  route_table_id = resource.aws_route_table.pf_route_table.id
  #############################################################
  subnet_id = resource.aws_subnet.pf_private_subnet_2.id
}
