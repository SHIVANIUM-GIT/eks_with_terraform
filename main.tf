module "vpc" {
  source     = "./modules/vpc"
  name       = var.name
  cidr_block = var.cidr_block
  pub_subnet = var.pub_subnet
  pri_subnet = var.pri_subnet
}

module "eks" {
  source = "./modules/eks"

  name = var.name
}