resource "aws_route_table_association" "eks-public-subnet-01-association" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "eks-public-subnet-02-association" {
  subnet_id      = aws_subnet.public-subnet-02.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "eks-private-subnet-01-association" {
  subnet_id      = aws_subnet.private_subnets_eks_ec2_01.id
  route_table_id = aws_route_table.eks-private-01-route.id
}

resource "aws_route_table_association" "eks-private-subnet-02-association" {
  subnet_id      = aws_subnet.private_subnets_eks_ec2_02.id
  route_table_id = aws_route_table.eks-private-02-route.id
}


resource "aws_route_table_association" "db-private-subnet-01-association" {
  subnet_id      = aws_subnet.private-subnet-db-01.id
  route_table_id = aws_route_table.db-private-01-route.id
}

resource "aws_route_table_association" "db-private-subnet-02-association" {
  subnet_id      = aws_subnet.private-subnet-db-02.id
  route_table_id = aws_route_table.db-private-02-route.id
}

