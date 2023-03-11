resource "aws_db_parameter_group" "this" {
  name   = "${var.project}-${var.env}-parametergroup"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  tags = {
    "Name" = "${var.project}-${var.env}-parametergroup"
  }
}

resource "aws_db_option_group" "this" {
  name                 = "${var.project}-${var.env}-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  tags = {
    "Name" = "${var.project}-${var.env}-optiongroup"
  }
}

resource "aws_db_subnet_group" "this" {
  name = "${var.project}-${var.env}-subnetgroup"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id,
  ]

  tags = {
    "Name" = "${var.project}-${var.env}-subnetgroup"
  }
}

resource "aws_db_instance" "this" {
  engine         = "mysql"
  engine_version = "8.0.28"

  identifier = "${var.project}-${var.env}-mysql"

  username = "admin"
  password = var.rdspass

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = true

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.this.name
  option_group_name      = aws_db_option_group.this.name
  publicly_accessible    = false
  port                   = 3306
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  db_name = "testdb"

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:07:00"
  auto_minor_version_upgrade = false

  deletion_protection = false
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    "Name" = "${var.project}-${var.env}-mysql"
  }
}