# Creates an AWS Security Group and its associated ingress/egress rules to 
# manage network traffic, allowing open HTTP access, SSH access, and unrestricted outbound traffic.

resource "aws_security_group" "sg" {
  name        = "security_group"
  description = "Allow HTTP and SHH inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "MySecurityGroup"
  }
}

# 2. INBOUND RULE: HTTP (Port 80) from the World
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0" # Open to the public internet
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allows all traffic access to your vpc" # <-- Use this instead of tags
}

# 3. INBOUND RULE: SSH (Port 22) from a Restricted IP
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0" # SEC_TIP: Swap with your actual home/work public IP
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH access" # <-- Use this instead of tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"                      # semantically equivalent to all ports
  description       = "Public HTTP web traffic" # <-- Use this instead of tags
}


