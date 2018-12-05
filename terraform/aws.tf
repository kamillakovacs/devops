# aws.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "PUBLIC_SSH_KEY" {}

provider "aws" {
  region = "us-east-1"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = "${var.PUBLIC_SSH_KEY}"
}

resource "aws_instance" "web" {
 ami = "ami-0f9351b59be17920e"
 instance_type = "t2.micro"
 key_name = "${aws_key_pair.test-key.key_name}"

 tags {
   Name = "Checkout_Mattermost"
 }
}
