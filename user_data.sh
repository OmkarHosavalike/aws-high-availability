#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)

echo "<html>
<head><title>Web Server Info</title></head>
<body>
<h1>Hello from EC2</h1>
<p>Instance ID: ${INSTANCE_ID}</p>
<p>Availability Zone: ${AZ}</p>
</body>
</html>" > /var/www/html/index.html
