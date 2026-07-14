# Creating a application load balancer
resource "aws_lb" "alb" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnets

  enable_deletion_protection = false
}


# Creating a Target Group  for the listener
resource "aws_lb_target_group" "alb_TG" {
  name     = "Alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}



# Listener
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
resource "aws_lb_target_group_attachment" "tga" {
  count            = length(var.instances)
  target_group_arn = aws_lb_target_group.alb_TG.arn
  target_id        = var.instances[count.index]
  port             = 80
}