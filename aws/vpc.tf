module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"

  name = "${var.p-name}-vpc"
  cidr = "10.0.0.0/16"

  azs                  = ["${var.region}a", "${var.region}b", "${var.region}c"]
  database_subnets     = ["10.0.3.0/24", "10.0.6.0/24", "10.0.9.0/24"]
  private_subnets      = ["10.0.12.0/22", "10.0.16.0/22", "10.0.20.0/22"]
  private_subnet_names = ["eks-workers-a", "eks-workers-b", "eks-workers-c"]
  intra_subnets        = ["10.0.33.0/24", "10.0.36.0/24", "10.0.39.0/24"]
  intra_subnet_names   = ["cache-a", "cache-b", "cache-c"]
  public_subnets       = ["10.0.203.0/24", "10.0.206.0/24", "10.0.209.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  database_subnet_group_name         = "primary_db_subnet_group"
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_flow_log      = true


  tags = {
    Terraform   = "true"
    Environment = "sandbox"
    Version     = "0.1.0"
  }
}
