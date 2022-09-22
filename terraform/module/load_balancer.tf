
resource "aws_lb_target_group" "pf_load_balancer_target_group" {
  name       = "${var.environment_name}-pf-lb-target-group"
  depends_on = [resource.aws_vpc.pf_vpc]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = resource.aws_vpc.pf_vpc.id
}

resource "aws_lb" "pf_load_balancer" {
  load_balancer_type               = "application"
  internal                         = false
  enable_cross_zone_load_balancing = true
  subnets                          = [resource.aws_subnet.pf_public_subnet_1.id, resource.aws_subnet.pf_public_subnet_2.id]
  security_groups                  = [resource.aws_security_group.pf_security_group.id]
}

resource "aws_lb_listener" "pf_lb_listener" {
  load_balancer_arn = resource.aws_lb.pf_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = resource.aws_lb_target_group.pf_load_balancer_target_group.arn
  }

  tags = {
    name = "${var.environment_name}-lb"
  }
}
