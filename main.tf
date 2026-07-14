module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnets_cidr = var.subnets_cidr
}

# This is the security group main parent module
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}
/*

module "ec2" {
  source  = "./modules/ec2"
  sg_id   = module.sg.sg_id
  subnets = module.vpc.subnet_id

}

module "alb" {
  source    = "./modules/alb"
  sg_id     = module.sg.sg_id
  subnets   = module.vpc.subnet_id
  vpc_id    = module.vpc.vpc_id
  instances = module.ec2.instance_ids
}
*/