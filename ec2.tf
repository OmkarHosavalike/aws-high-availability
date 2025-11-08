resource "aws_security_group" "web_sg" {
  vpc_id      = aws_vpc.main.id
  description = "Allow Http and SSH access"

  tags = {
    Name = "web-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "name" {
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.web_sg.id
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  description       = "Allow http from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "flaskport" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
  description       = "Allow flask port from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  cidr_ipv4         = "${chomp(data.http.my_ip.response_body)}/32"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.web_sg.id
  ip_protocol       = "tcp"
  description       = "Allow SSH from current IP"
}


