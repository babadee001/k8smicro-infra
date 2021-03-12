output "instance_ip" {
  value = aws_instance.scalac_instance.public_ip 
}