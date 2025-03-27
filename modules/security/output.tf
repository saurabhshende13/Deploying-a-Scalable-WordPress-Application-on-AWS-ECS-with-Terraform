output "alb_sg_id" {
  description = "ID of the Application Load Balancer security group"
  value       = aws_security_group.alb_sg.id
}

output "db_sg_id" {
  description = "ID of the Application Load Balancer security group"
  value       = aws_security_group.db_sg.id
}

# output "ecs_sg_id" {
#   description = "ID of the Application Load Balancer security group"
#   value       = aws_security_group.ecs_sg.id
# }