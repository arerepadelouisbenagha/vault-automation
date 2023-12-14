# Virtual Private Cloud Module
module "vpc" {
  providers               = { aws = aws.aws }
  source                  = "git::https://github.com/bootcampus-elitesolutionsit/terraform-vpc-module.git?ref=v2.0.0"
  name                    = "vault"
  security_group_name     = "vault-sg"
  description             = "security for infrastructure"
  cidr_block              = "10.0.0.0/16"
  enable_dns_support      = true
  instance_tenancy        = "default"
  public_subnets          = ["10.0.0.0/20"]
  private_subnets         = ["10.0.64.0/20"]
  map_public_ip_on_launch = true
  azs                     = ["us-east-1a"]
  security_group_ingress = [{

    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0" # Keep this to allow ansible login the application vm
  }]
  security_group_egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }]
}