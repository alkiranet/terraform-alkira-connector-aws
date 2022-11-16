/*
Alkira data sources
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs
*/
data "alkira_billing_tag" "tag" {
  for_each = toset(var.billing_tags)
  name     = each.key
}

data "alkira_credential" "credential" {
  name = var.credential
}

data "alkira_group" "group" {
  name = var.group
}

data "alkira_policy_prefix_list" "prefix" {
  for_each = {
    for k, v in toset(local.filter_custom_prefixes) : k => v
    if var.custom_routing == true
  }
  name     = each.key
}

data "alkira_segment" "segment" {
  name = var.segment
}

locals {

  filter_custom_prefixes = flatten([
    for rtb in var.routing_options : [
      for pfx in rtb.prefix_lists : 
        pfx
    ]
  ])

  pfx_id_list = [
    for v in data.alkira_policy_prefix_list.prefix : v.id
  ]

  filter_routing_options = flatten([
    for r in var.routing_options : {
      id               = r.route_table_id
      options          = r.route_option
      prefix_list_ids  = [for pfx in r.prefix_lists : lookup(data.alkira_policy_prefix_list.prefix, pfx, null).id]
    }
  ])

  # filter tag ids
  tag_id_list = [
    for v in data.alkira_billing_tag.tag : v.id
  ]

}

/*
alkira_connector_aws_vpc
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc
*/
resource "alkira_connector_aws_vpc" "connector" {

  # Connector values
  aws_account_id                  = var.aws_account_id
  aws_region                      = var.aws_region
  billing_tag_ids                 = local.tag_id_list
  credential_id                   = data.alkira_credential.credential.id
  cxp                             = var.cxp
  direct_inter_vpc_communication  = var.direct_inter_vpc
  enabled                         = var.enabled
  failover_cxps                   = var.failover_cxps
  group                           = data.alkira_group.group.name
  name                            = var.name
  segment_id                      = data.alkira_segment.segment.id
  size                            = var.size
  vpc_id                          = var.vpc_id
  vpc_cidr                        = var.onboard_subnet ? null : var.vpc_cidr

  # If bool == true, use custom subnet for linked availability zones
  dynamic "tgw_attachment" {
    for_each = {
      for o in var.tgw_attachment : o.subnet_id => o
      if var.custom_tgw == true
    }

    content {
      az         = tgw_attachment.value.az
      subnet_id  = tgw_attachment.value.subnet_id
    }
  }

  # If bool == true, onboard custom subnets in place of entire VPC CIDR block
  dynamic "vpc_subnet" {
    for_each = {
      for o in var.subnets : o.subnet_id => o
      if var.onboard_subnet == true
    }

    content {
      id   = vpc_subnet.value.subnet_id
      cidr = vpc_subnet.value.subnet_cidr
    }
  }

  # If bool == true, use custom routing options
  dynamic "vpc_route_table" {
    for_each = {
      for o in local.filter_routing_options : o.id => o
      if var.custom_routing == true
    }

    content {
      id              = vpc_route_table.value.id
      options         = vpc_route_table.value.options
      prefix_list_ids = vpc_route_table.value.prefix_list_ids
    }
  }

}