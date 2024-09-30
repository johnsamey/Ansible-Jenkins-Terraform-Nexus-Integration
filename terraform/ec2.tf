resource "aws_security_group" "my_sec" {
for_each =var.my-sec-data
  
  
  vpc_id = aws_vpc.main[each.value[0]].id

  ingress {
    from_port   = each.value[1]
    to_port     = each.value[1]
    protocol    = each.value[2]
    cidr_blocks = [each.value[3]]
  }

  ingress {
    from_port   = each.value[4]
    to_port     = each.value[4]
    protocol    = each.value[5]
    cidr_blocks = [each.value[6]]
  }
  ingress = {
    from_port   = each.value[7]
    to_port     = each.value[7]
    protocol    = each.value[8]
    cidr_blocks = [each.value[9]]
  }

  egress {
    from_port   = each.value[10]
    to_port     = each.value[10]
    protocol    = each.value[11]
    cidr_blocks = [each.value[12]]
  }

  tags = {
    Name = each.key
  }
}


resource "aws_instance" "nexus_instance" {
  for_each = var.my-ec2-data
  ami                    = each.value[0]  
  instance_type          = each.value[1]                
  subnet_id              = aws_subnet.nexus_subnet[each.value[2]].id         
  associate_public_ip_address = each.value[3]

vpc_security_group_ids = [aws_security_group.my_sec[each.value[4]].id]


  key_name = each.value[5]

  user_data = each.value[6]

  tags = {
    Name = each.key
  }
}
