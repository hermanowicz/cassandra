resource "aws_instance" "workers-zone-b" {

  count = 3

  instance_type = "t3.small"
  # default amazon linux 2023, for now
  ami                  = var.dub-ami
  iam_instance_profile = "SSM_EC2"
  # default for now
  key_name                    = var.dub-key-name
  associate_public_ip_address = false
  monitoring                  = true
  ebs_optimized               = true

  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [aws_security_group.workers.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    iops                  = 1000
    volume_size           = 10
    volume_type           = "gp3"
    tags = {
      Name = "worker-1-labs-vol-1"
    }
  }

  user_data = "sudo su && dnf update -y && dnf install -y git wget python3-pip"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "worker-${count.index}"
  }
}
