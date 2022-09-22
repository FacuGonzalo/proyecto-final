bucket_name   = "terraform-state-devops-project"
dynamodb_name = "terraform-state-locking"

region                    = "us-west-2"
bastion_availability_zone = "us-west-2a"
domain                    = "devops-proyecto-final.com"

ami      = "ami-0d70546e43a941d70" # Ubuntu 22.04 LTS // us-west-2
key_name = "proyecto-key"

db_name           = "pf_database"
db_user           = "pf_user"
db_engine         = "postgres"
db_engine_version = "12"
db_storage        = "standard"