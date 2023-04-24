# EC2 Instance
resource "aws_instance" "bastion" {               
  ami                    = data.aws_ami.amzlinux2.id                      
  instance_type          = "t2.micro"
  user_data              = file("${path.module}/bastion-user-data/bastion-host-user-data.sh")
  key_name               = "jenkins-key"
  vpc_security_group_ids = [aws_security_group.ssh_http_sg.id]     

  subnet_id = data.aws_subnet.eks_public_subnet_01.id    

  tags = {
    "Name" = "bastion-host"
  }
}


        
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  vpc      = true
  tags = {
    "Name" = "Bastion Pulic IP"
  }
}



resource "null_resource" "copy_ec2_keys" {
  depends_on = [aws_instance.bastion]
  
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip      
    user        = "ec2-user"       
    password    = ""
    private_key = file("private-key/jenkins-key.pem")     
  }

  
  provisioner "file" {
    source      = "private-key/jenkins-key.pem"
    destination = "/tmp/jenkins-key.pem"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/jenkins-key.pem"         
    ]
  }
}
