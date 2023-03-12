resource "aws_lb" "this" {
  name               = "${var.project}-${var.env}-app-elb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.elb_sg.id
  ]

  subnets = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1c.id
  ]

  tags = {
    "Name" = "${var.project}-${var.env}-app-elb"
  }
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project}-${var.env}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-app-tg"
  }

}

resource "aws_lb_target_group_attachment" "app_tg_attache" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.app.id
}