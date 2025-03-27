variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}


# variable "alb_target_group" {
#   description = "Target group ARN for ECS service"
#   type        = string
#   default     = data.aws_lb_target_group.ecs_tg.arn
# }

# variable "aws_ecs_task_definition" {
#   description = "Target group ARN for ECS service"
# }

variable "db_name" {
  description = "db name"
}

variable "db_user" {
  description = "db user"
}

variable "db_password" {
  description = "db password"
}

variable "region" {
  description = "default region"
}