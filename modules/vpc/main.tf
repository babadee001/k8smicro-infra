provider "aws" {
  region  = "eu-west-2"
}


resource "aws_vpc" "scalac_vpc" {
  cidr_block            = var.vpc_cidr
  instance_tenancy      = "default"
  enable_dns_hostnames  = true

  tags = {
    Name = "scalac-vpc"
  }
}

resource "aws_internet_gateway" "scalac_igw" {
  vpc_id                  = aws_vpc.scalac_vpc.id
  tags = {
    "Name" = "scalac-igw"
  }
}

resource "aws_subnet" "scalac_public_subnet" {
    vpc_id                = aws_vpc.scalac_vpc.id
    cidr_block            = var.subnet_cidr
    availability_zone     = var.subnet_availability_zone
    map_public_ip_on_launch = true

    tags = {
      "Name"              = "public_subnet"
    }
}

resource "aws_route_table" "scalac_public_rt" {
    vpc_id                = aws_vpc.scalac_vpc.id

    route {
      cidr_block          = "0.0.0.0/0"
      gateway_id          = aws_internet_gateway.scalac_igw.id
    }
    tags = {
      "Name"              = "public_rt"
    }
}

resource "aws_route_table_association" "scalac_public_rt_association" {
  subnet_id               = aws_subnet.scalac_public_subnet.id
  route_table_id          = aws_route_table.scalac_public_rt.id
}

resource "aws_security_group" "scalac_sg" {
  vpc_id = aws_vpc.scalac_vpc.id
  name = "scalac security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}