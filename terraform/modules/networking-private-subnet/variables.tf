
variable "environment" {
  description = "AWS Deployment environment."
}
variable "vpc_cidr" {
  description = "ciderblock for VPC."
}

variable "availability_zones" {
  description = "availability_zones for region"
}

variable "private_subnets_cidr" {
  description = "ciderblock for private subnet."
}
variable "name" {
  description = "the name of vpc."
}
variable "securityzone"{
  description = "the tag of private vpc"
}
