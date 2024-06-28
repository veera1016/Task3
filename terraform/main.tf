
variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}

resource "aws_security_group" "strapi-sg" {
  name        = "strapi-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}


resource "aws_instance" "strapi" {
  ami           = data.aws_ami.ubuntu.id
  #ami           = var.ami  # Ubuntu 20.04 LTS AMI
  instance_type = var.instance_type
  key_name      = "devops"
    tags = {
        Name = "Strapi-Instance"
     }

  
provisioner "remote-exec" {
    inline = [
              "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "sudo chmod 666 /var/run/docker.sock",
      #"docker pull priya247/${var.docker_image}",  # Replace with your Docker image
      "docker run -d -p 80:80 -p 1337:1337 priya247/mystrapi247:latest"  

            
    ]
  }
   connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file(var.private_key_path)  # Replace with the path to your private key
    host        = self.public_ip
  }
 
  security_groups = [aws_security_group.strapi-sg.name]
}
