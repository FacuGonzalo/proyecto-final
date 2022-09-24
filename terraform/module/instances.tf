resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = var.AWS_INSTANCE_PUBLIC_KEY
}

resource "aws_launch_configuration" "pf_instance_launch_conf" {
  name_prefix                 = var.project_name
  image_id                    = var.ami
  instance_type               = var.instance_type
  key_name                    = resource.aws_key_pair.generated_key.key_name
  security_groups             = [resource.aws_security_group.pf_security_group.id]
  associate_public_ip_address = true

  user_data = file("${path.module}/scripts/init.sh")

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "init" {
  template = file("${path.module}/scripts/init-bastion.sh")

  vars = {
    AWS_ACCESS_KEY_ID             = var.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY         = var.AWS_SECRET_ACCESS_KEY
    AWS_INSTANCE_PRIVATE_KEY      = var.AWS_INSTANCE_PRIVATE_KEY
    AWS_INSTANCE_PRIVATE_KEY_NAME = "/home/ubuntu/${resource.aws_key_pair.generated_key.key_name}"
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.bastion_availability_zone
  subnet_id              = resource.aws_subnet.pf_public_subnet_1.id
  vpc_security_group_ids = [resource.aws_security_group.pf_security_group.id]
  key_name               = resource.aws_key_pair.generated_key.key_name
  user_data              = data.template_file.init.rendered
  depends_on = [
    resource.aws_autoscaling_group.pf_asg
  ]

  tags = {
    Name = "bastion-${var.environment_name}"
  }
}
