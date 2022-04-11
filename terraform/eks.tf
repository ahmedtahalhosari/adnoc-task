module "EKS-Admin" {
  source                   = "./modules/eks"
  subnets_eks              = module.admin_VPC.public_subnets
  vpc_id_eks               = module.admin_VPC.vpc_id
}
