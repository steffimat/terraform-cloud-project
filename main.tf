provider "aws" {
  region     = "ca-central-1"
  secret_key = "uDXTGk78jcvbP7fk1iOz0odoZsqotCKEI4m3rRD+"
  access_key = "AKIAU6GDWMRZT7Y3UB55"
}

resource "aws_instance" "web_testing" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "terra-key"
 
  tags = {
    Name = "web_testing"


  }
}
resource "aws_eip" "lb"{
  domain ="vpc"
}

output "public_ip" {
  value = aws_eip.lb.public_ip

}


resource "aws_security_group" "TF_SG" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = "vpc-0ee480fabf0779b58"

  
ingress {
    description  = "HTTPS"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

ingress {
    description  = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
ingress {
    description  = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

tags = {
    Name = "TF_SG"
  }
}







