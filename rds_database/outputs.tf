output "rds_database_endpoint" {
  value = aws_db_instance.mysql_rds.endpoint
}

output "rds_port" {
  value = aws_db_instance.mysql_rds.port
}

output "rds_sg_id" {
  value = aws_security_group.db_security_group.id
}