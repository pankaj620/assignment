resource "aws_alb" "main" {
  name            = "jenkins-load-balancer"
  subnets         = ["subnet-084af0705c79cb79b","subnet-0a3093c306ee8816a","subnet-07f5e5c744da93cb6"]
  security_groups = ["sg-02e8ccdf4912b25c1","sg-08aa5d12e67394666","sg-02597fc27eb245906"]
}

resource "aws_alb_target_group" "app" {
  name        = "cb-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = "vpc-097c99f302ae32211"
  target_type = "ip"
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}