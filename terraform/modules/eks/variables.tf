variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = ""
      username = ""
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = ""
      username = ""
      groups   = ["system:masters"]
    },
  ]
}
variable "subnets_eks" {
  description = "ciderblock for private subnet."
}
variable "vpc_id_eks" {
  description = "id of the vpc"
}
