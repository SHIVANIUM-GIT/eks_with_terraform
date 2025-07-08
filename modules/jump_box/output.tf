output "jump_server_public_ip" {
  value = aws_instance.jump_server.public_ip
}

output "jump_server_private_ip" {
  value = aws_instance.jump_server.private_ip
}
