#!/bin/bash

# Update package lists
sudo apt-get update -y
# Install Nginx
sudo apt-get install nginx -y
# Start Nginx service
sudo systemctl start nginx
# Enable Nginx to start on boot
sudo systemctl enable nginx
# Check Nginx status
sudo systemctl status nginx

# Create a simple HTML file to verify Nginx is working
echo "<html><head><title>Nginx Test</title></head><body><h1>Nginx is successfully installed and running!</h1></body></html>" | sudo tee /var/www/html/index.html

