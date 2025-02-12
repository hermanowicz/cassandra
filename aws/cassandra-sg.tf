resource "aws_security_group" "cassandra-sg" {
  vpc_id      = module.vpc.vpc_id
  name        = "cassandra-sg"
  description = "primary cassandra security group with default rules"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "sshd"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 7000
    to_port     = 7000
    protocol    = "tcp"
    description = "Inter cluster comms"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 7199
    to_port     = 7199
    protocol    = "tcp"
    description = "jmx cluster monitoring"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 7001
    to_port     = 7001
    protocol    = "tcp"
    description = "inter cluster comms wit ssl"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 9042
    to_port     = 9042
    protocol    = "tcp"
    description = "cassandra native client port"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 9142
    to_port     = 9142
    protocol    = "tcp"
    description = "cassandra native client port with ssl"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Terraform   = true
    Environment = "sandbox"
    Version     = "0.1.0"
  }
}
