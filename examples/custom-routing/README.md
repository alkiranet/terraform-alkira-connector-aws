## Custom Routing
The following example configuration will create an AWS VPC and subnets using the [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) and then connect it to Alkira using the [AWS Connector Module](https://registry.terraform.io/modules/alkiranet/connector-aws/alkira/latest). We will then adjust the routing behavior from the _AWS VPC_ to Alkira's _CXP_.
- Add the flag **custom_routing = true**
- Add the **vpc_route_table** block with the appropriate values

### Routing Options
By default, Alkira will override the existing default route and route traffic to the _CXP_. As an alternative, you can provide a list of prefixes for which traffic must be routed. In the example below, we reference two different subnets. The first subnet, we set to **ADVERTISE_DEFAULT_ROUTE** while the second subnet we **ADVERTISE_CUSTOM_PREFIX**:

```hcl
custom_routing = true

vpc_route_table = [
    {
      option          = "ADVERTISE_DEFAULT_ROUTE"
      route_table_id  = "rtb-01234"
    },
    {
      option          = "ADVERTISE_CUSTOM_PREFIX"
      prefix_lists    = ["pfx-list-01", "pfx-list-02"]
      route_table_id  = "rtb-56789"
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