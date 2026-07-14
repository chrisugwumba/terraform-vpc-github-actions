variable "sg_id" {
  description = "SG ID for application load balancer"
  type        = string

}

variable "subnets" {
  description = "Subnets ID for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "instances" {
  description = "EC2 instances ID Target Group Attachment"
  type        = list(string)

}