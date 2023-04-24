

data "aws_vpc" "adl_eks_vpc" {                        
  filter {
    name   = "tag:Name"                                       
    values = ["2560-dev-alpha1-vpc"]
  }
}

data "aws_subnet" "eks_public_subnet_01" {       
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha1-vpc-public-subnet-01"]           
  }
}


