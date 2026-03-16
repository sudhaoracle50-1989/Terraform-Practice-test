### vpc ###
resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Dev-VPC"
    }
  
}
### Subnets ###
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
  
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet"
  }
  
}
### Internet Gateway ###
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "Dev-IG"
  }
  
}
### Nat Gateway ###
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "dev-nat"
  }
}
### RouteTable for internet ###
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_ig.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public.id
}

### route table for nat gateway ###
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.private.id  
}

### Security Group ###
resource "aws_security_group" "public-sg" {
  name = "Public-SG"
  description = "Allow"
  vpc_id = aws_vpc.dev-vpc.id
  #inbound rule 
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }  
  #outbound rule 
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}

### Bastion ec2 ###
resource "aws_instance" "bastion" {
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [ aws_security_group.public-sg.id ]
  tags = {
    Name = "Bastion-ec2"
  }
}