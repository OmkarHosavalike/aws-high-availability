output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.web_tg.arn
  description = "ARN of the Target Group"
}

output "key_pair_private_key" {
  value       = tls_private_key.key.private_key_pem
  sensitive   = true
  description = "Private key for accessing the EC2 instance from ansible"
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.name
}
