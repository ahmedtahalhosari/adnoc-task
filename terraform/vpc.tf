
module "public_VPC" {
  source                        = "./modules/networking"
  name                          = "edge"
  environment                   = "dev"
  vpc_cidr                      = "10.1.0.0/16"
  public_subnets_cidr           = ["10.1.1.0/24", "10.1.2.0/24", "10.1.4.0/24"]
  private_subnets_inbound_cidr  = ["10.1.3.0/24", "10.1.5.0/24", "10.1.6.0/24"]
  private_subnets_outbound_cidr = ["10.1.7.0/24", "10.1.8.0/24", "10.1.9.0/24"]
  availability_zones            = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "admin_VPC" {
  source               = "./modules/networking-private-subnet"
  name                 = "taas_admin"
  environment          = "dev"
  vpc_cidr             = "10.2.0.0/16"
  private_subnets_cidr = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  availability_zones   = slice(data.aws_availability_zones.available.names, 0, 3)
  securityzone         = "A"
}