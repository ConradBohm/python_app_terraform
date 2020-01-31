output "db_ip" {
  description = "the public ip of the db"
  value = aws_instance.db_instance.private_ip
}
