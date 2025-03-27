variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}


variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS instance in GB"
  type        = number
}

variable "db_engine" {
  description = "Database engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
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
  description = "CIDR blocks for application private subnets"
  type        = list(string)
}


variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "ARN of SSL certificate for ALB"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
}
