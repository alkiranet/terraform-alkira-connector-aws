## TGW Attachment
The following example configuration will create an AWS VPC and subnets using the [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) and then connect it to Alkira using the [AWS Connector Module](https://registry.terraform.io/modules/alkiranet/connector-aws/alkira/latest). The default behavior selects a subnet automatically for the _tgw attachment_. The following example will use specific subnets -> availability zones.

- Add the flag **custom_tgw = true**
- Add the **tgw_attachment** block with the appropriate values

```hcl
custom_tgw = true

tgw_attachment = [
  {
    az         = "us-east-2b"
    subnet_id  =  module.create_vpc.private_subnets[0]
  },
  {
    az         = "us-east-2c"
    subnet_id  =  module.create_vpc.private_subnets[1]
  }
]
```

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