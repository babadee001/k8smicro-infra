provider "aws" {
  region  = "eu-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "template_cloudinit_config" "config" {

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/server_init.sh")
  }
}

# resource "tls_private_key" "scalac_tls" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

resource "aws_key_pair" "key_pair" {
  key_name = "scalac_pem"
  public_key = file(var.public_key_path) //tls_private_key.scalac_tls.public_key_openssh
}

resource "aws_instance" "scalac_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  user_data                   = data.template_cloudinit_config.config.rendered
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  subnet_id                   = var.subnet_id 
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key_pair.key_name

  tags = {
    Name = "scalac_instance"
  }
}