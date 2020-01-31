resource "aws_subnet" "db_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.my_name
  }
}

resource "aws_route_table" "priv_route" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.my_name
  }
}

resource "aws_route_table_association" "db_assoc" {
  subnet_id = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.priv_route.id
}

resource "aws_security_group" "db_sg" {
  name        = "Eng48-conrad-bohm-db"
  description = "Allow traffic from app"
  vpc_id      = var.vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.my_name
  }
}

resource "aws_instance" "db_instance" {
  ami = var.ami_id
  subnet_id = aws_subnet.db_subnet.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = var.my_name
  }
}
