# // docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

# resource "aws_lb" "nlb-internal-labs" {
#   name                             = "nlb-internal-labs"
#   internal                         = true
#   load_balancer_type               = "network"
#   security_groups                  = [aws_security_group.nlb-internal-sg.id]
#   subnets                          = [module.vpc.intra_subnets[0], module.vpc.intra_subnets[1], module.vpc.intra_subnets[2]]
#   enable_cross_zone_load_balancing = true

#   enable_deletion_protection = false

#   tags = {
#     Project : var.p-name
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

# resource "aws_security_group" "nlb-internal-sg" {
#   vpc_id      = module.vpc.vpc_id
#   name        = "nlb-internal-sg"
#   description = "Security group for the Internal NLB"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [module.vpc.vpc_cidr_block]
#   }

#   ingress {
#     from_port   = 9042
#     to_port     = 9042
#     protocol    = "tcp"
#     cidr_blocks = [module.vpc.vpc_cidr_block]
#     description = "cassandra native client traffic from vpc"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [module.vpc.vpc_cidr_block]
#   }
# }

# resource "aws_lb_target_group" "nlb-internal-via-id-group" {
#   name        = "nlb-internal-via-id-group"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = module.vpc.vpc_id
#   target_type = "ip"

#   health_check {
#     enabled             = true
#     protocol            = "TCP"
#     port                = 9042
#     interval            = 10
#     timeout             = 3
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

# resource "aws_lb_listener" "nlb-internal-listener" {
#   load_balancer_arn = aws_lb.nlb-test-labs.arn
#   port              = 9042
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "nlb-via-ip-group-attachment-1-internal" {
#   target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   target_id        = aws_instance.worker-1.private_ip
#   port             = 9042
# }

# resource "aws_lb_target_group_attachment" "nlb-via-ip-group-attachment-2-internal" {
#   target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   target_id        = aws_instance.worker-2.private_ip
#   port             = 9042
# }
