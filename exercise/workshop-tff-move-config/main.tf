provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway      = var.vpc_enable_nat_gateway
  map_public_ip_on_launch = true

  tags = var.vpc_tags
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "compute" {
  source         = "./modules/compute"
  security_group = module.security_group.security_group_id
  public_subnets = module.vpc.public_subnets
}