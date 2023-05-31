terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  key_name = "aws_lab_alura_oregon"
  user_data = <<-EOF
                  #!/bin/bash
                  cd /home/ubuntu
                  echo "<h1>Subida via Terraform</h1>" > index.html
                  nohup busybox httpd -f -p 8080 &
                  EOF
  tags = {
    Name = "instance terraform code"
  }
}
