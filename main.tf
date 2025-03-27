module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  db_private_subnets = var.db_private_subnets
  environment        = var.environment
}

module "security" {
  source      = "./modules/security"
  vpc_id      = module.network.vpc_id
  environment = var.environment
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  security_group_id   = module.security.alb_sg_id
  ssl_certificate_arn = var.ssl_certificate_arn
  environment         = var.environment
}

# module "task_def" {
#   source = "./modules/task_def"
# }

# module "ecs" {
#   source            = "./modules/ecs"
#   ecs_cluster_name  = "wp-cluster"
#   task_definition   = module.task_def.task_arn
#   security_groups   = [module.security.ecs_sg.id]
#   subnets           = module.network.private_subnets
#   alb_target_group  = module.alb.target_group_arn
# }

module "rds" {
  source               = "./modules/rds"
  vpc_id               = module.network.vpc_id
  availability_zones   = var.availability_zones
  subnet_ids           = module.network.db_private_subnet_ids
  security_group_id    = module.security.db_sg_id
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  environment          = var.environment
}
