bucket_name   = "terraform-state-devops-final-project"
dynamodb_name = "terraform-state-locking"

region                    = "us-east-1"
bastion_availability_zone = "us-east-1a"
domain                    = "devops-proyecto-final.com"

ami      = "ami-08c40ec9ead489470" # Ubuntu 22.04 LTS // us-east-1
key_name = "proyecto-key"

db_name           = "pf_database"
db_user           = "pf_user"
db_engine         = "postgres"
db_engine_version = "12"
db_storage        = "standard"