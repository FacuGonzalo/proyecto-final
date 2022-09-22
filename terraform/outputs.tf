output "dns_url" {
  value = module.environment.dns_url
}

output "bastion_url" {
  value = module.environment.bastion_url
}

output "instance_name" {
  value = local.project_name[local.environment_name]
}