locals {
  common_tags = {
    Environment     = var.environment
    Project         = "VF-TAAS"
    ManagedBy       = "taas@vodafone.com"
    Confidentiality = "C2"
    TaggingVersion  = "V2.4"
    Repository      = "taas.foundation-infrastructure"
    SecurityZone    = var.securityzone

    # temp solution:
    "kubernetes.io/role/internal-elb"               = "1"
    "kubernetes.io/cluster/dev-gks-shared" = "shared"
    "kubernetes.io/cluster/dev-gks-management" = "shared"
    "kubernetes.io/cluster/dev-gks-apigee" = "shared"
    "kubernetes.io/cluster/dev-gks-vault" = "shared"
  }
}
