# -----------------------------------------------
# EC2 Module - variables.tf
# -----------------------------------------------

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_1_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
}

variable "sg_id" {
  description = "Security group ID to attach to the EC2 instance"
  type        = string
}
