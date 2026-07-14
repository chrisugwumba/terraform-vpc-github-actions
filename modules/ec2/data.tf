data "aws_ami" "amazon-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_availability_zones" "available" {
  state = "available"

}