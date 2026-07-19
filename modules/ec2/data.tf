
# Dynamic AMI Finder: Automatically discovers the latest Amazon Linux 2 image.
# Instead of hardcoding a static AMI ID (which changes frequently and varies by region),
# this block queries AWS for an exact match based on ownership, virtualization type,
# and architecture. The 'most_recent = true' setting ensures that every fresh 
# 'terraform apply' picks up the latest patched and secure version of the image.
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

# Retrieves all active and available Availability Zones within the targeted AWS region.
data "aws_availability_zones" "available" {
  state = "available"

}