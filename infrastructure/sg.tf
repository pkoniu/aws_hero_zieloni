resource "aws_security_group" "sg-ecs" {
  name        = "ECS-security-group"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.aws_hero_hackathon.id}"
  tags {
    Name        = "sg-ecs"
  }
}

resource "aws_security_group_rule" "sg-ecs-allow_all_from_sg-ecs" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.sg-ecs.id}"
  security_group_id        = "${aws_security_group.sg-ecs.id}"
}

resource "aws_security_group_rule" "sg-ecs-allow_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg-ecs.id}"
}