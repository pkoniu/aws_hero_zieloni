resource "aws_vpc" "aws_hero_hackathon" {
    cidr_block = "10.0.0.0/16"

    tags {
        Name = "aws_hero_hackathon"
    }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_p1" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags {
    Name = "aws_hero_hackathon_subnet_p1"
  }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_p2" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"

  tags {
    Name = "aws_hero_hackathon_subnet_p2"
  }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_p3" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"

  tags {
    Name = "aws_hero_hackathon_subnet_p3"
  }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_h1" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "aws_hero_hackathon_subnet_h1"
  }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_h2" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-1b"

  tags {
    Name = "aws_hero_hackathon_subnet_h2"
  }
}

resource "aws_subnet" "aws_hero_hackathon_subnet_h3" {
  vpc_id     = "${aws_vpc.aws_hero_hackathon.id}"
  cidr_block = "10.0.6.0/24"
  availability_zone = "eu-west-1c"

  tags {
    Name = "aws_hero_hackathon_subnet_h3"
  }
}