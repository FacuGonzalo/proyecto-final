
# # Create EIP for NAT GW1  
# resource "aws_eip" "pf_elastic_ip_1" {
#   vpc = true
# }

# # Create NAT gateway1
# resource "aws_nat_gateway" "pf_nat_gateway_1" {
#   allocation_id = resource.aws_eip.pf_elastic_ip_1.id
#   subnet_id     = resource.aws_subnet.pf_public_subnet_1.id
# }

# # Create EIP for NAT GW2 
# resource "aws_eip" "pf_elastic_ip_2" {
#   vpc = true
# }
# # Create NAT gateway2 
# resource "aws_nat_gateway" "pf_nat_gateway_2" {
#   allocation_id = resource.aws_eip.pf_elastic_ip_2.id
#   subnet_id     = resource.aws_subnet.pf_public_subnet_2.id
# }
