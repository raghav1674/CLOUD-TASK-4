

variable "own_public_subnet_cidr"{}

variable "own_private_subnet_cidr"{}

variable "own_public_subnet_availability_zone"{}

variable "own_private_subnet_availability_zone"{}






// creating public subnet

resource "aws_subnet" "public_subnet" {
depends_on=[aws_vpc.own_vpc]
  vpc_id     = aws_vpc.own_vpc.id
  cidr_block = var.own_public_subnet_cidr        
  map_public_ip_on_launch = "true"  
   availability_zone= var.own_public_subnet_availability_zone

  tags = {
    Name = "public_subnet"
  }
}



//  creating private subnet

resource "aws_subnet" "private_subnet" {
depends_on=[aws_vpc.own_vpc]
  vpc_id     = aws_vpc.own_vpc.id
  cidr_block = var.own_private_subnet_cidr

 availability_zone=var.own_private_subnet_availability_zone
  tags = {
    Name = "private_subnet"
  }
}



// creating route table for public subnet 

resource "aws_route_table" "public_subnet_route_table" {
      depends_on=[aws_subnet.public_subnet]
  vpc_id = aws_vpc.own_vpc.id



 

  route {
    cidr_block = "0.0.0.0/0"
   
    gateway_id = aws_internet_gateway.igw.id
  }




  tags = {
    Name = "public_subnet_route_table"
  }
}



 // associating the route table with the public subnet 
 
resource "aws_route_table_association" "public_subnet_route_table_association" {
      depends_on=[aws_route_table.public_subnet_route_table]
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}






//  creating the security group for public subnet 

resource "aws_security_group" "allow_public_web" {
    depends_on=[aws_subnet.public_subnet]
  name        = "allow_http_ssh_ping"
  description = "Allow SSH PING HTTP inbound traffic"
  vpc_id      =  aws_vpc.own_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   
    ipv6_cidr_blocks  = ["::/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks   = ["::/0"]
  }
    
    
ingress {
    description = "icmp from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "allow_http_ssh_ping"
  }
}


//  creating sg-bositon

resource "aws_security_group" "only_ssh_bositon" {
  depends_on=[aws_subnet.public_subnet]
  name        = "only_ssh_bositon"
  description = "Allow ssh bositon inbound traffic"
  vpc_id      =  aws_vpc.own_vpc.id


 ingress {
    description = "Only ssh_basiton in public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

 
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "only_ssh_bositon"
  }
}





resource "aws_security_group" "only_sql_web" {
    depends_on=[aws_subnet.public_subnet]
  name        = "only_sql_web"
  description = "Allow only sql web inbound traffic"
  vpc_id      =  aws_vpc.own_vpc.id


 ingress {
    description = "Only web  sql from public subnet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups=[aws_security_group.allow_public_web.id]
    
  }

  ingress {
    description = "Only web ping sql from public subnet"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    security_groups=[aws_security_group.allow_public_web.id]
    ipv6_cidr_blocks=["::/0"]
    
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "only_sql_web"
  }
}

//  creating allow-bositon host to ssh sql

resource "aws_security_group" "only_ssh_sql_bositon" {
    depends_on=[aws_subnet.public_subnet]
  name        = "only_ssh_sql_bositon"
  description = "Allow ssh bositon inbound traffic"
  vpc_id      =  aws_vpc.own_vpc.id


 ingress {
    description = "Only ssh_sql_bositon in public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups=[aws_security_group.only_ssh_bositon.id]
 
 }


 
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "only_ssh_sql_bositon"
  }
}



































