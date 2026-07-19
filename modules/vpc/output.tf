# Returns the unique, auto-generated ID of the primary Virtual Private Cloud (VPC).
# This ID is essential for attaching external resources, such as Security Groups,
# Internet Gateways, or future microservices, to this specific network boundary.

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}


# Returns a complete list of IDs for all subnets created by the subnet resource block.
# By using the asterisk (*) splat operator, this output dynamically collects the IDs 
# of all instances generated via 'count', making it easy to map compute resources
# (like EC2 instances or load balancers) evenly across multiple availability zones.

output "subnet_id" {
  value = aws_subnet.subnets.*.id

}