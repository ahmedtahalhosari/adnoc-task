# variable "region" {
#   description = "AWS Deployment region."
# }
variable "environment" {
  description = "AWS Deployment environment."
}
variable "vpc_cidr" {
  description = "ciderblock for VPC."
}
variable "public_subnets_cidr" {
  description = "ciderblock for public subnet."
}
variable "availability_zones" {
  description = "availability_zones for region"
}

variable "private_subnets_inbound_cidr" {
  description = "ciderblock for private inbound subnet."
}

variable "private_subnets_outbound_cidr" {
  description = "ciderblock for private outbound subnet."
}

variable "name" {
  description = "the name of vpc."
}
variable "nat_name" {
  description = "the name of nat of public vpc."
  default = "main_NAT"
}

variable "igw_name" {
  description = "the name of igw of public vpc."
  default = "IGW"
}

# variable "public-name" {
#   description = "the name of public subnet."
# }
# variable "private-name" {
#   description = "the name of private subnet."
# }
//////////////////////
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}
