terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-devops-project"
    key            = "workspaces/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}

# AWS Availability zone
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.region
}

module "environment" {
  source = "./module"

  environment_name = local.environment_name
  project_name     = local.project_name[local.environment_name]

  # State management
  bucket_name   = var.bucket_name
  dynamodb_name = var.dynamodb_name

  # AWS CLI
  AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY

  # Public and private keys
  AWS_INSTANCE_PUBLIC_KEY  = var.AWS_INSTANCE_PUBLIC_KEY
  AWS_INSTANCE_PRIVATE_KEY = var.AWS_INSTANCE_PRIVATE_KEY

  # AWS Region and domains
  create_dns_zone           = local.create_dns_zone[local.environment_name]
  region                    = var.region
  bastion_availability_zone = var.bastion_availability_zone
  domain                    = var.domain

  # Auto scaling group
  instance_type           = local.instance_type[local.environment_name]
  pf_asg_min_capacity     = local.pf_asg_min_capacity[local.environment_name]
  pf_asg_max_capacity     = local.pf_asg_max_capacity[local.environment_name]
  pf_asg_desired_capacity = local.pf_asg_desired_capacity[local.environment_name]

  # Database
  db_instance_type  = local.db_instance_type[local.environment_name]
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_storage        = var.db_storage

  # AMI For EC2 Instances
  ami      = var.ami
  key_name = "${var.key_name}-${local.environment_name}"
}
