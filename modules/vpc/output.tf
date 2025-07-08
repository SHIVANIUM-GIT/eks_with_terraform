output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "pub_subnet_id" {
    value = aws_subnet.public[*].id
}

output "pri_subnet_id" {
    value = aws_subnet.private[*].id
}

output "security_group_Control_id" {
    value = aws_security_group.node-group-sg.id
}

output "jump_box_sg_id" {
  value = aws_security_group.jump-box-sg.id
}