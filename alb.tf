resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/health"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name = "web-tg"
  }
}

resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
