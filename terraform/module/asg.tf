resource "aws_autoscaling_group" "pf_asg" {
  depends_on           = [resource.aws_lb.pf_load_balancer]
  name                 = "${var.environment_name}-${var.project_name}-asg"
  launch_configuration = resource.aws_launch_configuration.pf_instance_launch_conf.name
  min_size             = var.pf_asg_min_capacity
  max_size             = var.pf_asg_max_capacity
  desired_capacity     = var.pf_asg_desired_capacity
  force_delete         = true

  vpc_zone_identifier = [resource.aws_subnet.pf_private_subnet_1.id, resource.aws_subnet.pf_private_subnet_2.id]
  health_check_type   = "EC2"

  target_group_arns = [resource.aws_lb_target_group.pf_load_balancer_target_group.arn]

  tag {
    key                 = "instancemode"
    value               = "node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}"
    propagate_at_launch = true
  }
}
