locals {
  environment_name = terraform.workspace

  project_name = {
    dev  = "dev_proyecto_final_devops"
    prod = "prod_proyecto_final_devops"
  }

  instance_type = {
    dev  = "t2.micro"
    prod = "t2.micro"
  }

  pf_asg_min_capacity = {
    dev  = 1,
    prod = 1
  }

  pf_asg_max_capacity = {
    dev  = 2,
    prod = 4
  }

  pf_asg_desired_capacity = {
    dev  = 1,
    prod = 1
  }

  db_instance_type = {
    dev  = "db.t2.micro"
    prod = "db.t2.micro"
  }

  create_dns_zone = {
    dev  = true
    prod = true
  }
}
