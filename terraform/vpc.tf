resource "aws_vpc" "nexus_vpc" {
 for_each = var.vpc-data
 cidr_block = each.value
 
 tags = {
   Name = each.key
 }
}
resource "aws_subnet" "nexus_subnet" {
  vpc_id = aws_vpc.nexus_vpc[each.value[2]].id
  for_each = var.subnet-data
  cidr_block = each.value[0]
  availability_zone = each.value[1]
  tags = {
    Name = each.key,
  }
}

resource "aws_internet_gateway" "nexus_igw" {
  for_each = var.igw-data
  vpc_id = aws_vpc.nexus_vpc[each.value].id

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "nexus_route_table" {
  for_each = var.my-routes-data
  vpc_id = aws_vpc.main[each.value[0]].id

  route {
    cidr_block = each.value[1]
    gateway_id = aws_internet_gateway.nexus_igw[each.value[2]].id
  }


  tags = {
    Name = each.key
  }
  depends_on = [ aws_internet_gateway.gw ]
}

resource "aws_route_table_association" "terraform-associate" {

  for_each = var.terraform-associate-data
  subnet_id      = aws_subnet.nexus_subnet[each.key].id
  route_table_id = aws_route_table.nexus_route_table[each.value[0]].id
}


