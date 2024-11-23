#provedor aws
provider "aws" {
    region = "us-east-1"

}

#chave publica da AWS
resource "aws_key_pair" "my_key" {
    key_name = "my-key"
    public_key = file("my-key.pem.pub")
}

#grupo de segurança
resource "aws_security_group" "ec2_sg"{
    name        = "ec2-security-group"
    description = "Security group for EC2 instance"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["200.198.1.214/32"]


    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#instancia EC2
resource "aws_instance" "my_ec2" {
    ami           = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"

    key_name        = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.ec2_sg.name]

    tags = {
        Nme = "DevOps-EC2-Instance"
    } 
}

#Banco de dados (opcional)
#resource "aws_db_instance" "my_rds" {
#  allocated_storage    = 20
#  engine               = "mysql"
#  engine_version       = "8.0"
#  instance_class       = "db.t2.micro"
#  name                 = "mydb"
#  username             = "admin"
#  password             = "StrongPassword123" # Substitua por uma senha forte
#  publicly_accessible  = false
#  skip_final_snapshot  = true
#
#  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
#
#  tags = {
#    Name = "My-RDS-Instance"
#  }
#}