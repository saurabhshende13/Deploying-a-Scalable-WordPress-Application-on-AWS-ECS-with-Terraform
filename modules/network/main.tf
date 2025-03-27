resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
    Tier = "Public"
  }
}


# Private Subnets
resource "aws_subnet" "private" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.environment}-private-subnet-${count.index + 1}"
    Tier = "Private"
  }
}

# Private Subnets
resource "aws_subnet" "db_private" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.db_private_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.environment}-db-private-subnet-${count.index + 1}"
    Tier = "DBPrivate"
  }
}


resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "default-internet-gateway"
  }
}

# NAT Gateway Elastic IP
resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  
  tags = {
    Name = "${var.environment}-nat-eip-${count.index + 1}"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    Name = "${var.environment}-nat-gateway-${count.index + 1}"
  }
  
  depends_on = [aws_internet_gateway.default]
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  
  tags = {
    Name = "${var.environment}-public-route-table"
    Tier = "Public"
  }
}

# DB Private Route Tables
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = {
    Name = "${var.environment}-private-route-table-${count.index + 1}"
    Tier = "Private"
  }
}

# Private Route Tables
resource "aws_route_table" "db_private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-private-route-table-${count.index + 1}"
    Tier = "Private"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# App Private Route Table Association
resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# DB Private Route Table Association
resource "aws_route_table_association" "db_private" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.db_private[count.index].id
  route_table_id = aws_route_table.db_private[count.index].id
}