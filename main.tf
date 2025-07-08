module "vpc" {
  source     = "./modules/vpc"
  name       = var.name
  cidr_block = var.cidr_block
  pub_subnet = var.pub_subnet
  pri_subnet = var.pri_subnet
}

module "eks" {
  source = "./modules/eks"

  name           = var.name
  vpc_id         = module.vpc.vpc_id
  pub_subnet_id  = module.vpc.pub_subnet_id
  pri_subnet_id  = module.vpc.pri_subnet_id
  sg_control_id  = module.vpc.security_group_Control_id
  instance_type = var.instance_type
  ami_type       = var.ami_type
  jump_box_sg_id = module.vpc.jump_box_id
}

module "jump_box" {
  source = "./modules/jump_box"

  name           = var.name
  pub_subnet_id  = module.vpc.pub_subnet_id
  instance_ami   = var.instance_ami
  instance_type =  var.instance_type
  jump_box_sg_id = module.vpc.jump_box_id

}