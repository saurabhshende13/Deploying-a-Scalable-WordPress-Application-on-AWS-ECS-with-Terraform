variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for application private subnets"
  type        = list(string)
}

variable "db_private_subnets" {
  description = "CIDR blocks for db private subnets"
  type        = list(string)
}

variable "environment" {
  description = "CIDR blocks for application private subnets"
  type        = string
}