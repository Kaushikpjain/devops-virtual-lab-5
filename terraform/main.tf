provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "devops_sg" {
  name        = "vle5-devops-sg"
  description = "Allow SSH from the CloudShell public IP"

  ingress {
    description = "SSH from CloudShell"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.107.58.47/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VLE5-DevOps-SG"
  }
}

resource "aws_instance" "devops_server" {
  ami                    = "ami-0c82c1a90be4dccc1"
  instance_type          = "t3.micro"
  key_name               = "vle5-devops-key"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOps-Lab-Server"
  }
}
