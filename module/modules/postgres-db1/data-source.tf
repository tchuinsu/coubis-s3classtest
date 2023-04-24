data "aws_vpc" "postgres_vpc" {            
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha1-vpc"]  
  }  
}

data "aws_subnet" "db-subnet-private-01" {          
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha1-vpc-private-subnet-db-01"]
  }
}

data "aws_subnet" "db-subnet-private-02" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha1-vpc-private-subnet-db-02"]
  }
}



data "aws_secretsmanager_secret" "rds_password" {
  name = "/2560/alpha1/db/databases-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id 
}


data "aws_secretsmanager_secret" "rds_username" {
  name = "/2560/alpha1/db/databases-usename"
}


data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id 
}

