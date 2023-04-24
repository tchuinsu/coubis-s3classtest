
data "aws_vpc" "vpc" {                                         
  filter {                                                      
    name   = "tag:Name"
    values = ["2560-dev-alpha1-vpc"]                                                 
  }                                                             
}

data "aws_subnet" "private_subnet" {
  filter {
    name   = "tag:Name"                     
    values = ["2560-dev-alpha1-vpc-private-subnet-db-01"]   
  }
}


