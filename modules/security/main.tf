# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-alb-sg"
  }
}


# # ECS Security Group
# resource "aws_security_group" "ecs_sg" {
#   name        = "${var.environment}-ecs-sg"
#   description = "Security group for ecs"
#   vpc_id      = var.vpc_id
  
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     security_groups = [aws_security_group.alb_sg.id]
#     description = "HTTP"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   tags = {
#     Name = "${var.environment}-ecs-sg"
#   }
# }

# DB Security Group
resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    description     = "MySQL from ECS"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-db-sg"
  }
}