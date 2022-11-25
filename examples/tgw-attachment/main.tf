module "create_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-east"
  cidr = "10.5.0.0/20"

  azs             = ["us-east-2b", "us-east-2c", "us-east-2b", "us-east-2-c"]
  private_subnets = ["10.5.1.0/24", "10.5.2.0/24", "10.5.3.0/24", "10.5.4.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

}

module "connect_vpc" {
  source  = "alkiranet/connector-aws/alkira"

  custom_tgw  = true

  name              = "connector-east"
  cxp               = "US-EAST-2"
  credential        = "aws-credential"
  billing_tags      = ["aws", "cloud", "dev"]
  segment           = "business"
  group             = "cloud"
  aws_account_id    = var.aws_account_id
  aws_region        = var.aws_region
  vpc_cidr          = [module.create_vpc.vpc_cidr_block]
  vpc_id            = module.create_vpc.vpc_id

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

  depends_on = [module.create_vpc]

}