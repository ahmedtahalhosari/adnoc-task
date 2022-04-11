locals {
  transit_gateway_config = {
    edge = {
      vpc_id                            = module.public_VPC.vpc_id
      vpc_name                          = module.public_VPC.vpc_name
      vpc_cidr                          = module.public_VPC.vpc_cidr
      subnet_ids                        = module.public_VPC.private_outbound_subnets
      subnet_route_table_ids            = module.public_VPC.public_route_table_ids
      route_to                          = ["admin"]
      route_to_cidr_blocks              = null
      transit_gateway_vpc_attachment_id = null

      static_routes = [
        {
          blackhole              = true
          destination_cidr_block = "192.168.0.0/16"
        },
        {
          blackhole              = false
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    },

    admin = {
      vpc_id                            = module.admin_VPC.vpc_id
      vpc_name                          = module.admin_VPC.vpc_name
      vpc_cidr                          = module.admin_VPC.vpc_cidr
      subnet_ids                        = module.admin_VPC.private_subnets
      subnet_route_table_ids            = module.admin_VPC.private_route_table_ids
      route_to                          = null
      route_to_cidr_blocks              = ["0.0.0.0/0"]
      transit_gateway_vpc_attachment_id = null
      static_routes                     = null
    },
  }
}

module "transit_gateway" {
  source = "./modules/transit-gateway"
  config = local.transit_gateway_config


}