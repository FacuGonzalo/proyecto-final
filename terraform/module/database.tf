# # RDS
# resource "aws_db_instance" "db_instance" {
#   allocated_storage          = 20
#   storage_type               = var.db_storage
#   engine                     = var.db_engine
#   engine_version             = var.db_engine_version
#   instance_class             = var.db_instance_type
#   db_name                    = var.db_name
#   username                   = var.db_user
#   password                   = var.db_password
#   auto_minor_version_upgrade = true
#   skip_final_snapshot        = true
#   publicly_accessible        = true
#   multi_az                   = false
#   db_subnet_group_name       = resource.aws_db_subnet_group.pf_private_db_subnet_group.name
# }
