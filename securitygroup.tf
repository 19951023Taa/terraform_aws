###  elb  ###
resource "aws_security_group" "elb_sg" {
  name        = "${var.project}-${var.env}-elb-sg"
  description = "${var.project}-${var.env}-elb-sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-elb-sg"
  }
}

resource "aws_security_group_rule" "elb_in_http" {
  security_group_id = aws_security_group.elb_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_in_https" {
  security_group_id = aws_security_group.elb_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_out" {
  security_group_id = aws_security_group.elb_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

###  app_ec2  ###
resource "aws_security_group" "app_ec2_sg" {
  name        = "${var.project}-${var.env}-app-ec2-sg"
  description = "${var.project}-${var.env}-app-ec2-sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-app-ec2-sg"
  }
}

resource "aws_security_group_rule" "app_ec2_in_http" {
  security_group_id        = aws_security_group.app_ec2_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "app_ec2_in_https" {
  security_group_id        = aws_security_group.app_ec2_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "app_ec2_out" {
  security_group_id = aws_security_group.app_ec2_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

###  opp_ec2  ###
resource "aws_security_group" "opp_sg" {
  name        = "${var.project}-${var.env}-opp_sg"
  description = "${var.project}-${var.env}-opp_sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-opp_sg"
  }
}

resource "aws_security_group_rule" "opp_in_ssh" {
  security_group_id = aws_security_group.opp_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["59.138.66.7/32"]
}

resource "aws_security_group_rule" "opp_out" {
  security_group_id = aws_security_group.opp_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

###  rds  ###
resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-${var.env}-rds_sg"
  description = "${var.project}-${var.env}-rds_sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-${var.env}-rds_sg"
  }
}

resource "aws_security_group_rule" "rds_in_mysql" {
  security_group_id        = aws_security_group.rds_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.app_ec2_sg.id
}

resource "aws_security_group_rule" "rds_out" {
  security_group_id = aws_security_group.rds_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}