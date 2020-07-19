
variable "own_vpc_cidr"{}



resource "aws_vpc" "own_vpc" {

  cidr_block       =  var.own_vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {

    Name = "own_vpc"
    
  }
}


resource "aws_internet_gateway" "igw" {
depends_on=[aws_vpc.own_vpc]
  vpc_id = aws_vpc.own_vpc.id

  tags = {
    Name = "igw"
  }
}

