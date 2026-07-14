variable "sg_id" {
  description = "SG id for ec2"
  type        = string
}
variable "subnets" {
  description = "Subnet for EC2"
  type        = list(string)

}
variable "ec2_names" {
  description = "Ec2 names"
  type        = list(string)
  default     = ["webserver1", "webserver2"]
}