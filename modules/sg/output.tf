# Ouputs the security group id to be passed to other resources that need 
# the security group access

output "sg_id" {
  value = aws_security_group.sg.id
}