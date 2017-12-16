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

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.aws_hero_hackathon.id}"
  tags {
    Name        = "Internet-gateway"
  }
}

resource "aws_eip" "nat-gateway1-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat-gateway1-eip.id}"
  subnet_id     = "${aws_subnet.aws_hero_hackathon_subnet_p1.id}"
}

resource "aws_route_table" "aws_hero_hackathon_route_table_p1" {
  vpc_id = "${aws_vpc.aws_hero_hackathon.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }
  tags {
    Name        = "Route-Table-Public1"
  }
}
resource "aws_route_table_association" "rt-asso-public1" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_p1.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_p1.id}"
}
resource "aws_route_table_association" "rt-asso-public2" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_p2.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_p1.id}"
}
resource "aws_route_table_association" "rt-asso-public3" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_p3.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_p1.id}"
}

resource "aws_route_table" "aws_hero_hackathon_route_table_h1" {
  vpc_id = "${aws_vpc.aws_hero_hackathon.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }
  tags {
    Name        = "Route-Table-Private1"
  }
}
resource "aws_route_table_association" "rt-asso-private1" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_h1.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_h1.id}"
}
resource "aws_route_table_association" "rt-asso-private2" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_h2.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_h1.id}"
}
resource "aws_route_table_association" "rt-asso-private3" {
  subnet_id      = "${aws_subnet.aws_hero_hackathon_subnet_h3.id}"
  route_table_id = "${aws_route_table.aws_hero_hackathon_route_table_h1.id}"
}