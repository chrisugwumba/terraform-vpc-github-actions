# Creating a application load balancer
resource "aws_lb" "alb" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnets

  # the alb attribute below prevents the accidental deletion of a load balancer when set to true
  # this is particularly useful in a production environment to prevent the accidental overloading of the 
  # service due to ALB downtime.
  # Here this is set to false because this particular environment is for dev or test where downtime tolerance is acceptable

  enable_deletion_protection = false 
}


# Creating a Target Group  for the listener
# Configures a logical target pool on port 80 to receive HTTP traffic 
# routing from an Application Load Balancer within the specified VPC.
resource "aws_lb_target_group" "alb_TG" {
  name     = "Alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


# Sets up a load balancer listener that monitors incoming public HTTP traffic on 
# port 80 and automatically forwards those requests directly to your Target Group.
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  # Because we are working with http and not https, we don't need the ssl_policy and certificate_arn
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_TG.arn
  }
}



#Target Group Attachment
# Dynamically loops through 'var.instances' to attach every EC2 instance 
# in the list to the Application Load Balancer's Target Group pool.
resource "aws_lb_target_group_attachment" "tga" {
  count            = length(var.instances)
  target_group_arn = aws_lb_target_group.alb_TG.arn
  target_id        = var.instances[count.index]
  port             = 80
}