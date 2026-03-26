# -----------------------------------------------
# RDS Module - variables.tf
# -----------------------------------------------

variable "subnet_1_id" {
  description = "First subnet ID for the RDS subnet group"
  type        = string
}

variable "subnet_2_id" {
  description = "Second subnet ID for the RDS subnet group"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "sg_id" {
  description = "Security group ID to attach to the RDS instance"
  type        = string
}
