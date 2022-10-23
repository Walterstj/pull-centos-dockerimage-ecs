resource "aws_subnet" "priv_sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  availability_zone_id    = "us-east-2"

  tags = {
    Name = "privSub1"
  }
}

resource "aws_subnet" "priv_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone_id    = "us-east-2"

  tags = {
    Name = "privSub2"
  }
}