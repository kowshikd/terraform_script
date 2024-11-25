resource "aws_security_group" "batch_environment_sg" {
  name_prefix = "${var.compute_environment_name}-"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "batch_environment_sg_egress" {
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
  security_group_id = aws_security_group.batch_environment_sg.id
}

resource "aws_security_group_rule" "batch_environment_sg_ssh" {
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.sg_groups
  type              = "ingress"
  security_group_id = aws_security_group.batch_environment_sg.id
}