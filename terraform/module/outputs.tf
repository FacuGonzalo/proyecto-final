output "dns_url" {
  value = resource.aws_lb.pf_load_balancer.dns_name
}

output "bastion_url" {
  value = resource.aws_instance.bastion.public_dns
}