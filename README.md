# Alkira AWS Connector
Terraform module that provisions [Alkira AWS Connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc). This can be used along with [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc) to handle the workflow _end-to-end_. This module is currently in _beta_.

## Basic Usage
```hcl
module "create_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-east-dev"
  cidr = "10.150.0.0/20"

  azs             = ["us-east-2b", "us-east-2c"]
  private_subnets = ["10.150.1.0/24", "10.150.2.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

}

module "connect_vpc" {
  source = "alkiranet/connector-aws/alkira"

  name              = "connector-east-dev"
  cxp               = "US-EAST-2"
  credential        = "aws-credential"
  segment           = "business"
  group             = "cloud"
  aws_account_id    = "123456789"
  aws_region        = "us-east-2"
  vpc_cidr          = [module.create_vpc.vpc_cidr_block]
  vpc_id            = module.create_vpc.vpc_id

  depends_on = [module.create_vpc]

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 0.9.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alkira"></a> [alkira](#provider\_alkira) | >= 0.9.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alkira_connector_aws_vpc.connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc) | resource |
| [alkira_billing_tag.tag](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/billing_tag) | data source |
| [alkira_credential.credential](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/credential) | data source |
| [alkira_group.group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/group) | data source |
| [alkira_policy_prefix_list.prefix](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/policy_prefix_list) | data source |
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/segment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | ID of AWS account for the VPC being connected | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region of the VPC being connected | `string` | n/a | yes |
| <a name="input_billing_tags"></a> [billing\_tags](#input\_billing\_tags) | Billing tags associated with connector | `list(string)` | `[]` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | Name of credential to use for onboarding VPC | `string` | n/a | yes |
| <a name="input_custom_routing"></a> [custom\_routing](#input\_custom\_routing) | Controls if custom routing is used from cloud network to CXP | `bool` | `false` | no |
| <a name="input_custom_tgw"></a> [custom\_tgw](#input\_custom\_tgw) | Controls if specific subnets are used for linked availability zones | `bool` | `false` | no |
| <a name="input_cxp"></a> [cxp](#input\_cxp) | CXP to provision connector in | `string` | n/a | yes |
| <a name="input_direct_inter_vpc"></a> [direct\_inter\_vpc](#input\_direct\_inter\_vpc) | Enable direct inter-vpc communication | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Status of connector | `bool` | `true` | no |
| <a name="input_failover_cxps"></a> [failover\_cxps](#input\_failover\_cxps) | Enable direct inter-vpc communication | `list(string)` | `[]` | no |
| <a name="input_group"></a> [group](#input\_group) | Group to associate with connector | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of connector | `string` | n/a | yes |
| <a name="input_onboard_subnet"></a> [onboard\_subnet](#input\_onboard\_subnet) | Controls if subnet gets onboarded in place of entire VPC CIDR block | `bool` | `false` | no |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | ID of VPC default route table | `string` | `""` | no |
| <a name="input_routing_options"></a> [routing\_options](#input\_routing\_options) | Custom routing options used to influence routing from cloud network to CXP | <pre>list(object({<br>    prefix_lists    = optional(list(string))<br>    route_option    = optional(string)<br>    route_table_id  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_segment"></a> [segment](#input\_segment) | Segment to provision connector in | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of connector | `string` | `"SMALL"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets to onboard in place of entire VPC CIDR block | <pre>list(object({<br>    subnet_id    = optional(string)<br>    subnet_cidr  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tgw_attachment"></a> [tgw\_attachment](#input\_tgw\_attachment) | Subnets to use for linked availability zones | <pre>list(object({<br>    az         = optional(string)<br>    subnet_id  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR of AWS VPC that is being connected | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of AWS VPC that is being connected | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connector_id"></a> [connector\_id](#output\_connector\_id) | ID of connector |
| <a name="output_implicit_group_id"></a> [implicit\_group\_id](#output\_implicit\_group\_id) | ID of implicit group automatically created with connector |
<!-- END_TF_DOCS -->