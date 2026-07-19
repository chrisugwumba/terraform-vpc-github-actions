# Outputs the list of unique AWS IDs generated for all deployed EC2 instances.

output "instance_ids" {
  value = aws_instance.web[*].id
}