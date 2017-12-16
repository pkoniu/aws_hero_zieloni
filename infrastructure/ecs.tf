resource "aws_ecs_cluster" "hackathon_ecs_cluster" {
  name = "hackathon"
}

resource "aws_iam_role_policy" "ecs-instance-policy" {
  name   = "hackathon_instance_policy"
  role   = "${aws_iam_role.ecs-instance-role.id}"
  policy = "${file("policies/ecs-instance-role-policy.json")}"
}

resource "aws_iam_role" "ecs-instance-role" {
  name               = "hackathon_ecs-instance-role"
  assume_role_policy = "${file("policies/ecs-instance-role.json")}"
}

resource "aws_iam_role_policy" "ecs-service-policy" {
  name   = "hackathon_ecs-service-policy"
  role   = "${aws_iam_role.ecs-service-role.id}"
  policy = "${file("policies/ecs-service-role-policy.json")}"
}

resource "aws_iam_role" "ecs-service-role" {
  name               = "hackathon_ecs-service-role"
  assume_role_policy = "${file("policies/ecs-service-role.json")}"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "hackathon_ecs-instance-profile"
  role = "${aws_iam_role.ecs-instance-role.id}"
}

data "aws_ami" "ecs-optimized" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-2017.*.g-amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # Amazon
}

resource "aws_launch_configuration" "asg-conf-ecs" {
  image_id                    = "${data.aws_ami.ecs-optimized.id}"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.hackathon-master.key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance-profile.id}"
  security_groups             = ["${aws_security_group.sg-ecs.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.hackathon_ecs_cluster.name} > /etc/ecs/ecs.config"
  associate_public_ip_address = false
  root_block_device {
    volume_type = "gp2"
    volume_size = 15
  }
  ebs_block_device {
    device_name = "/dev/xvdcz"
    volume_type = "gp2"
    volume_size = 25
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-ecs" {
  vpc_zone_identifier  = ["${aws_subnet.aws_hero_hackathon_subnet_h1.id}", "${aws_subnet.aws_hero_hackathon_subnet_h2.id}", "${aws_subnet.aws_hero_hackathon_subnet_h3.id}"]
  launch_configuration = "${aws_launch_configuration.asg-conf-ecs.name}"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 2
  lifecycle {
    create_before_destroy = true
  }
  tag = [
    {
      "key"                 = "Name"
      "value"               = "ECS Instance"
      "propagate_at_launch" = true
    },
  ]
}
