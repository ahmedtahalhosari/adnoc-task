module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "15.1.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.18"
  subnets         = var.subnets_eks

  tags = {
    Environment     = "dev"
    Project         = "task"
  }

  vpc_id = var.vpc_id_eks

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "default-pool"
      instance_type                 = "t3.2xlarge"
      additional_userdata           = "default node pool"
      asg_desired_capacity          = 3
    },
  ]
   map_roles                            = var.map_roles
   map_users                            = var.map_users
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
