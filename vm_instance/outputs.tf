output "public_dns" {
  value = aws_instance.lamp_web_server.public_dns
}

output "public_ip" {
  value = aws_instance.lamp_web_server.public_ip
}

output "lamp_sec_group_id" {
  value = aws_security_group.allow_ssh_http.id
}

output "lamp_sec_group_name" {
  value = aws_security_group.allow_ssh_http.name
}
