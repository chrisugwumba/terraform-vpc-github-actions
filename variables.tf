variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

variable "subnets_cidr" {
  description = "Subnet CIDRs"
  type        = list(string)

}