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

data "alkira_segment" "segment" {
  name = var.segment
}

locals {

  # filter ids
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
  aws_account_id   = var.aws_account_id
  aws_region       = var.aws_region
  billing_tag_ids  = local.tag_id_list
  credential_id    = data.alkira_credential.credential.id
  cxp              = var.cxp
  enabled          = var.enabled
  group            = data.alkira_group.group.name
  name             = var.name
  segment_id       = data.alkira_segment.segment.id
  size             = var.size
  vpc_id           = var.vpc_id
  vpc_cidr         = var.vpc_cidr

}