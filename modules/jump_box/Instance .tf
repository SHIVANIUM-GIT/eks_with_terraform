resource "aws_instance" "jump_server" {
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.pub_subnet_id[0] 
  key_name = "DevOps-Pratice"
  vpc_security_group_ids = [var.jump_server_sg_id]

  tags = {
    Name = "${var.name}-jump-server"
  }
  
}