variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

variable "subnets_cidr" {
  description = "Subnet CIDRs"
  type        = list(string)

}

# Subnet Variables Names
variable "subnet_names" {
  description = "Subnet Names"
  type        = list(string)
  default     = ["PublicSubnet1", "PublicSubnet2"]

}