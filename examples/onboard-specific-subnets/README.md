## Onboard Specific Subnets
The following example configuration will create an AWS VPC and subnets using the [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) and then connect it to Alkira using the [AWS Connector Module](https://registry.terraform.io/modules/alkiranet/connector-aws/alkira/latest). To onboard specific subnets in the configuration:
- Add the flag **onboard_subnet = true**
- Remove the parameter for **vpc_cidr**
- Add the **subnets** block with the appropriate values

```hcl
onboard_subnet = true

vpc_subnet = [
  {
    subnet_cidr = "10.5.1.0/24"
    subnet_id   = "subnet-01234"
  },
  {
    subnet_cidr = "10.5.2.0/24"
    subnet_id   = "subnet-56789"
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