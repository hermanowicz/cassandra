resource "aws_security_group" "nfs-sg" {
  name        = "nfs-sg"
  vpc_id      = module.vpc.vpc_id
  description = "base sg group for efs & fsx"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    description = "nfs protocol port tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "udp"
    description = "nfs protocol port udp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "tcp"
    description = "nfs protocol port rpc tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "udp"
    description = "nfs protocol port rpc udp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
}
