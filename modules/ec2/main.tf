#Creating an ec2 instance with the lenght parameter
# Deploys a dynamic number of public t3.micro EC2 instances.
# Loops through 'var.ec2_names' to assign unique names, subnets, and 
# Availability Zones to each instance, and executes a local startup script.

resource "aws_instance" "web" {
  count                       = length(var.ec2_names)
  ami                         = data.aws_ami.amazon-2.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnets[count.index]
  availability_zone           = data.aws_availability_zones.available.names[count.index]

  # Reads the standalone shell script from your root directory
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = var.ec2_names[count.index]
  }
}