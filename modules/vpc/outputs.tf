output "vpc_id" {
  value     = aws_vpc.scalac_vpc.id
}

output "subnet_id" {
  value     = aws_subnet.scalac_public_subnet.id
}

output "security_group_id" {
  value  =  aws_security_group.scalac_sg.id
}