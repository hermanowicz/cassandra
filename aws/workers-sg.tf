resource "aws_security_group" "workers" {
  name        = "labs-workers"
  vpc_id      = module.vpc.vpc_id
  description = "workers used in lab with public ip"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "labs-workers"
    Environment = "sandbox"
    Project     = "labs"
    Terraform   = "true"
  }

}
