#!/bin/bash
# This is a simple bashscript that installs and update an apache server using
# using the amazon linux 2 machine image
# Update the system
yum update -y

# Install Apache Web Server (Amazon Linux 2 / 2023)
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a sample HTML landing page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My EC2 Instance</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #74ebe1 0%, #d4a1ff 100%);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }
        .container {
            background-color: white;
            padding: 3rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #4A00E0;
            margin-bottom: 1rem;
        }
        p {
            font-size: 1.1rem;
            color: #666;
        }
        .badge {
            background-color: #00F260;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: bold;
            display: inline-block;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello from Terraform!</h1>
        <p>Your EC2 instance has been successfully provisioned and configured via User Data.</p>
        <div class="badge">Status: Online</div>
    </div>
</body>
</html>
EOF