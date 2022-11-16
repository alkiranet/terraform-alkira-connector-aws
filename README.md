# Alkira AWS Connector
Terraform module that provisions [Alkira AWS Connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc). This can be used along with [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc) to handle the workflow _end-to-end_. This module is currently in _beta_.

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
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/segment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | ID of AWS account for the VPC being connected | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region of the VPC being connected | `string` | n/a | yes |
| <a name="input_billing_tags"></a> [billing\_tags](#input\_billing\_tags) | Billing tags associated with connector | `list(string)` | `[]` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | Name of credential to use for onboarding VPC | `string` | n/a | yes |
| <a name="input_cxp"></a> [cxp](#input\_cxp) | CXP to provision connector in | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Status of connector | `bool` | `true` | no |
| <a name="input_group"></a> [group](#input\_group) | Group to associate with connector | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of connector | `string` | n/a | yes |
| <a name="input_segment"></a> [segment](#input\_segment) | Segment to provision connector in | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of connector | `string` | `"SMALL"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR of AWS VPC that is being connected | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of AWS VPC that is being connected | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connector_id"></a> [connector\_id](#output\_connector\_id) | ID of connector |
<!-- END_TF_DOCS -->