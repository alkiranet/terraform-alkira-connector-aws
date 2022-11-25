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

  onboard_subnet = true

  name              = "connector-east"
  billing_tags      = ["aws", "cloud", "dev"]
  cxp               = "US-EAST-2"
  credential        = "aws-credential"
  segment           = "business"
  group             = "cloud"
  aws_account_id    = var.aws_account_id
  aws_region        = var.aws_region
  vpc_id            = module.create_vpc.vpc_id

  vpc_subnet = [
    {
      subnet_id   = module.create_vpc.private_subnets[0]
      subnet_cidr = "10.5.1.0/24"
    },
    {
      subnet_id   = module.create_vpc.private_subnets[1]
      subnet_cidr = "10.5.2.0/24"
    }
  ]

  depends_on = [module.create_vpc]

}