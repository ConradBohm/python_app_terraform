# Set a provider
provider "aws" {
  region = "eu-west-1"
}

# create vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.my_name
  }
}

# create subnet
resource "aws_subnet" "app_subnet"{
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.my_name
  }
}

# create a security group
resource "aws_security_group" "app_security_cb" {
  name        = "Eng48-conrad-bohm-app"
  description = "Allow :80 inbound traffic - Eng48-conrad-bohm-app"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["212.161.55.68/32"]
  }


  tags = {
    Name = var.my_name
  }
}

# gateway
resource "aws_internet_gateway" "app_gw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = var.my_name
  }
}

# route table
resource "aws_route_table" "app_route"{
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_gw.id
  }

  tags = {
    Name = var.my_name
  }
}

# route table associations
resource "aws_route_table_association" "app_assoc" {
  subnet_id = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route.id
}

# launch an instance
resource "aws_instance" "app_instance" {
  ami     = var.ami_id
  subnet_id = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.app_security_cb.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = data.template_file.app_init.rendered
  key_name = "conrad-bohm-eng48-first-key"
  tags = {
    Name = var.my_name
  }
}

# send templates.sh file
data "template_file" "app_init" {
  template = "${file("./scripts/init_script.sh.tpl")}"

}
