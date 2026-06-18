resource "tls_private_key" "pipeline_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.pipeline_key.private_key_pem
  filename        = "${path.module}/ec2-private-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "demo-app-ssh-key"
  public_key = tls_private_key.pipeline_key.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami           = "ami-df5de72d"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key.key_name

  tags = {
    Name = "python-docker-server"
  }
}

output "server_ip" {
  value = aws_instance.app_server.public_ip
}
