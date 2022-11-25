## Onboard Complete VPC CIDR
The following example configuration will create an AWS VPC using the [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) and then connect it to Alkira using the [AWS Connector [Module](https://registry.terraform.io/modules/alkiranet/connector-aws/alkira/latest) with _default settings_.

:warning: The following resources must exist in _Alkira_ before referencing them in this configuration:
- [Billing Tag](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/billing_tag)
- [Credential](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/credential_aws_vpc)
- [Group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/group)
- [Segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/segment)

### Usage
To use this example, fill in the appropriate values in _variables.tf_ and provide those values _(including any secrets)_ by way of _terraform.tfvars_ or desired secrets management platform. Then run:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```