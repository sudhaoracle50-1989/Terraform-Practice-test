# -----------------------------------------------
# RDS Module - main.tf
# -----------------------------------------------

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "hr-rds-subnet-group"
  subnet_ids = [var.subnet_1_id, var.subnet_2_id]

  tags = {
    Name = "hr-rds-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier             = "hr-rds-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.sg_id]
  allocated_storage      = 20
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "hr-rds-instance"
  }
}
