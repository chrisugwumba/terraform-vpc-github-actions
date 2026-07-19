# Input variables that pass the required Security Group ID, target subnet IDs, 
# and custom server names into the EC2 instance configuration.

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