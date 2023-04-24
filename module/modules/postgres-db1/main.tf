resource "aws_db_instance" "alpha-db1" {
  instance_class          = "db.t2.small" 
  engine                  = "postgres"
  identifier              = "alpha-cicd-db"                      
  engine_version          = "10.20"
  port                    = 5432        
  multi_az                = false      
  publicly_accessible     = false
  deletion_protection     = false     
  storage_encrypted       = true
  storage_type            = "gp2"
  allocated_storage       = 20
  max_allocated_storage   = 50
  name                    = "alpha"
  username                = data.aws_secretsmanager_secret_version.rds_username.secret_string
  password                = data.aws_secretsmanager_secret_version.rds_password.secret_string
  apply_immediately       = "true"    
  backup_retention_period = 0
  skip_final_snapshot     = true
  
  db_subnet_group_name   = aws_db_subnet_group.alpha-postgres-db-subnet.name
  vpc_security_group_ids = ["${aws_security_group.alpha-postgres-db-sg.id}"]

  tags = {
    Name = "postgres-alpha-cicd-db"
  }
}


resource "aws_db_subnet_group" "alpha-postgres-db-subnet" {
  name = "alpha-postgres-db-subnet"
  subnet_ids = [
    "${data.aws_subnet.db-subnet-private-01.id}",
    "${data.aws_subnet.db-subnet-private-02.id}",
  ]
}

resource "aws_route53_record" "cluster-alias" {
  depends_on = [aws_db_instance.alpha-db1]
  zone_id    = "Z07911201RP"       
  name       = "Trump2024"                  
  type       = "CNAME"
  ttl        = "60"
                                               
  
  records    = [aws_db_instance.alpha-db1.endpoint]
}                                       
resource "aws_security_group" "alpha-postgres-db-sg" {
  name   = "postgres-rds-sg"
  vpc_id = data.aws_vpc.postgres_vpc.id
}

resource "aws_security_group_rule" "postgres-rds-sg-rule" {
  from_port         = 5432
  protocol          = "tcp"
  to_port           = 5432
  security_group_id = aws_security_group.alpha-postgres-db-sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.alpha-postgres-db-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}










