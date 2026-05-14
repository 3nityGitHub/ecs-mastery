# Public subnets for ALB
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = data.aws_vpc.main.id
  cidr_block              = ["10.0.1.0/24", "10.0.2.0/24"][count.index]
  availability_zone       = ["eu-west-2a", "eu-west-2b"][count.index]
  map_public_ip_on_launch = true

  tags = {
    Name    = "talium-public-subnet-${count.index + 1}-prod"
    Tier    = "public"
    Project = "talium-tech"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name    = "talium-igw-prod"
    Project = "talium-tech"
  }
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name    = "talium-public-rt-prod"
    Project = "talium-tech"
  }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
