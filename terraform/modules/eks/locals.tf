# URLs for the different helm repositories
locals {
  helm_repository_datadog = "https://helm.datadoghq.com/"
}
locals {
  common_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "eks-apigee-edge"
}
