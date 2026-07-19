# The IP address range for the entire VPC network (e.g., "10.0.0.0/16").
variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

# A list of IP ranges to allocate to individual subnets within the VPC.
variable "subnets_cidr" {
  description = "Subnet CIDRs"
  type        = list(string)

}

# The names applied to each subnet for organization and tracking in AWS
variable "subnet_names" {
  description = "Subnet Names"
  type        = list(string)
  default     = ["PublicSubnet1", "PublicSubnet2"]

}