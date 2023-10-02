resource "aws_key_pair" "aws_key" {
  key_name   = "aws-key"
  public_key = file("C:/Users/wladimir.souza/Documents/Chaves AWS")
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

resource "aws_instance" "vm" {
  ami                         = "ami-053b0d53c279acc90" //necessário pegar a AMI correta da região. Isso se pega na plataforma da AWS indo em EC2
  instance_type               = "t2.micro"  
  subnet_id                   = aws_subnet.subnet.id
  key_name                    = aws_key_pair.aws_key.key_name
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true  

  provisioner "file" {
    source      = "./2121_wave_cafe"
    destination = "/tmp/site/"
  }

  provisioner "file" {
    source = "./script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [       
"sudo apt-get update",
"cd /tmp/",
"sudo chmod +x script.sh",
"sudo sh script.sh",
"sudo docker build -t minhaimagem .",
"sudo docker container run --name containerdocker -p 80:80 -d minhaimagem"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/wladimir.souza/Documents/Chaves AWS")
    host        = self.public_ip
  }

  tags = {
    "Name" = "Ubuntu"
  }

}

