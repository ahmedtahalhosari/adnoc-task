locals {
  common_tags = {
    Environment     = var.environment
    Project         = "VF-TAAS"
    ManagedBy       = "taas@vodafone.com"
    Confidentiality = "C2"
    TaggingVersion  = "V2.4"
    Repository = "taas.foundation-infrastructure"
    SecurityZone = "A"
  }
}