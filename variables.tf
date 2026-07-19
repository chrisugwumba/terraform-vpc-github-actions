# This is the  VPC CIDR range variable declaration
variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

# This is the subnet CIDR range variable declaration
variable "subnets_cidr" {
  description = "Subnet CIDRs"
  type        = list(string)

}