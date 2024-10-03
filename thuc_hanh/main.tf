provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source    = "./modules/subnet"
  vpc_id    = module.vpc.vpc_id
  cidr_pub  = "10.0.1.0/24"
  cidr_priv = "10.0.2.0/24"
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "nat_gateway" {
  source         = "./modules/nat_gateway"
  public_subnet  = module.subnets.public_subnet_id
}

module "route_tables" {
  source           = "./modules/route_tables"
  vpc_id           = module.vpc.vpc_id
  igw_id           = module.internet_gateway.igw_id
  nat_gateway_id   = module.nat_gateway.nat_gw_id
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  your_ip = "YOUR_IP/32" # Thay bằng IP của bạn
}

module "ec2" {
  source        = "./modules/ec2"
  public_sg_id  = module.security_group.public_sg_id
  private_sg_id = module.security_group.private_sg_id
  public_subnet = module.subnets.public_subnet_id
  private_subnet = module.subnets.private_subnet_id
  key_name      = "your-key-pair"  # Thay bằng key pair của bạn
}
