provider "aws" {
  region  = "eu-west-2"
}

module "vpc" {
    source                   = "./modules/vpc"
    vpc_cidr                 = var.vpc_cidr
    subnet_cidr              = var.subnet_cidr
    subnet_availability_zone = var.subnet_availability_zone
}

module "ec2" {
    source             = "./modules/ec2"
    public_key_path    = var.public_key_path
    vpc_security_group_ids   = module.vpc.security_group_id
    subnet_id                = module.vpc.subnet_id
}