module "create_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-east"
  cidr = "10.5.0.0/20"

  azs             = ["us-east-2b", "us-east-2c"]
  private_subnets = ["10.5.1.0/24", "10.5.2.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

}

module "connect_vpc" {
  source  = "alkiranet/connector-aws/alkira"

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

  depends_on = [module.create_vpc]

}