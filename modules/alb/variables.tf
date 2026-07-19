# Input variables that pass the required Security Group ID, public subnet IDs, 
# target VPC ID, and backend EC2 instance IDs into the Load Balancer setup.

# Provides the security group id for the load balancer id
variable "sg_id" {
  description = "SG ID for application load balancer"
  type        = string

}


# provide the subnet ids the loadbalancer will attach to
variable "subnets" {
  description = "Subnets ID for ALB"
  type        = list(string)
}

# Provide the VPC id the load balancer attaches
variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

# provides the id of the instances that the loadbalancer will route traffic to
variable "instances" {
  description = "EC2 instances ID Target Group Attachment"
  type        = list(string)

}