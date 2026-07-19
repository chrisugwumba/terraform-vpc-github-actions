# Retrieves a list of dynamically available AWS Availability Zones (AZs) in the active region.
# Filtering by state = "available" ensures we avoid provisioning resources in impaired 
# or isolated AZs that are undergoing maintenance or aren't yet active for the account.


data "aws_availability_zones" "available" {
  state = "available"
}