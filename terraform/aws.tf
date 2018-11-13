# aws.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}


# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "eu-central-1"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMHC3tzmjdEvubmvBNJlkLBjogpniryWTvqBpxdKvz9owc5KaDdhP5Z528CeUTZ0vnz89JN9yTNXTnSieb5tFAjSHR7RlbLWoOh6Cbu9aLfCXmMAMMB/ORANqqVPAm4cIiF7vqJJ829Cq1VWlfm8OSNpkV9V1pslf4E4W0XR9q/B7he4pXoNQ6L7v1mOgJlj9obYQbWbzP7TDvuAIoOm3TEJWdCTSxHNX4VrUMZap+rqojzjaR8o++JftrecRMq89uJdgltw6+7SAvOePeHuwrwGLBhX1DB8uT2CPYg1Dw+Obn4FjwdPRXlHa+JrHd0sp19fY/q0kjjdkcrCgGIsIh kamilla@Kamillas-MacBook-Air.local"
}

resource "aws_instance" "web" {
  ami           = "ami-00259791f61937520"
  instance_type = "t2.micro"  
  key_name = "${aws_key_pair.test-key.key_name}"
  tags {
    Name = "Test Instance"
  }
}
