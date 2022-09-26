########################################
# Project
########################################

variable "project_name" {
  description = "Project name"
  type        = string
  sensitive   = true
}

variable "environment_name" {
  description = "Environment"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "name of s3 bucket for app data"
  type        = string
}

variable "dynamodb_name" {
  description = "name of dynamodb for app data"
  type        = string
}

########################################
# AWS CLI
########################################

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
}

########################################
# General AWS Variables
########################################

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-west-2"
}

# Route 53 Variables
variable "domain" {
  description = "Domain for website"
  type        = string
}

variable "create_dns_zone" {
  description = "Create DNS zone"
  type        = bool
  default     = false
}

########################################
# EC2 Variables
########################################

variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-0d70546e43a941d70" # Ubuntu 22.04 LTS // us-west-2
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "key_name" {
  type    = string
}

variable "AWS_INSTANCE_PUBLIC_KEY" {
  type = string
}

variable "AWS_INSTANCE_PRIVATE_KEY" {
  type      = string
  sensitive = true
}

variable "bastion_availability_zone" {
  type        = string
  description = "us-west-2a"
}

########################################
# Auto scaling group
########################################

variable "pf_asg_min_capacity" {
  description = "Min capacity of the auto scaling group"
  type        = number
}

variable "pf_asg_max_capacity" {
  description = "Max capacity of the auto scaling group"
  type        = number
}

variable "pf_asg_desired_capacity" {
  description = "Desired capacity of the auto scaling group"
  type        = number
}

########################################
# DATABASE
########################################

variable "db_instance_type" {
  description = "rds instance type"
  type        = string
}

variable "db_engine" {
  description = "rds engine"
  type        = string
}

variable "db_engine_version" {
  description = "rds engine version"
  type        = string
  default     = "12"
}

variable "db_storage" {
  description = "rds storage"
  type        = string
  default     = "standard"
}

variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "db_user" {
  description = "Username for DB"
  type        = string
}

variable "db_password" {
  description = "Password for DB"
  type        = string
  sensitive   = true
}

########################################
# VPC
########################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pub_sub1_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "pub_sub2_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "prv_sub1_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.3.0/24"
}

variable "prv_sub2_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.4.0/24"
}

########################################
# Docker
########################################

variable "DOCKER_IMAGE" {
  description = "Docker image version"
  type        = string
}

variable "DOCKER_CONTAINER" {
  description = "Docker container name"
  type        = string
}