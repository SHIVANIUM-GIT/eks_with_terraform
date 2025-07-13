data "aws_availability_zones" "availability" {
  state = "available"
}

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags =  {
        Name = "${var.name}-vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.name}-igw"
    }
  
}

resource "aws_eip" "eip" {
  count = length(var.pri_subnet)
  domain = "vpc"

  tags={
    Name = "${var.name}-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat"{
  count = length(var.pri_subnet)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.name}-NAT-${count.index + 1}"
  }

  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_subnet" "public" {
  count = length(var.pub_subnet)

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_subnet[count.index]
  map_public_ip_on_launch = true  
  availability_zone = data.aws_availability_zones.availability.names[count.index]

  tags = {
    "kubernetes.io/role/elb" = "1"
    Name = "${var.name}-${count.index +1}-public-subnet-${data.aws_availability_zones.availability.names[count.index]}"
  }
}


resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"             
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-pub-rt"
  }
}

resource "aws_route_table_association" "pub_route_table" {
    count = length(var.pub_subnet)

    route_table_id = aws_route_table.pub_route.id
    subnet_id = aws_subnet.public[count.index].id
}


resource "aws_subnet" "private" {
  count = length(var.pri_subnet)

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pri_subnet[count.index]
  availability_zone = data.aws_availability_zones.availability.names[count.index]

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
    Name = "${var.name}-${count.index +1}-private-subnet-${data.aws_availability_zones.availability.names[count.index]}"
  }
}


resource "aws_route_table" "private_route" {
  count = length(var.pri_subnet)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"             
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "${var.name}-private-route-${count.index+ 1}"
  }
}

resource "aws_route_table_association" "private_route_table" {
    count = length(var.pri_subnet)

    route_table_id = aws_route_table.private_route[count.index].id
    subnet_id = aws_subnet.private[count.index].id
}

