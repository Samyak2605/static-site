# 🌐 Static Site Deployment with Nginx and rsync

This project demonstrates how to set up a remote Linux server using **AWS EC2**, configure **Nginx** to serve a static website, and use **rsync** for seamless deployments from your local machine.

## 🚀 Project Goals

- Launch and connect to a remote Linux server (EC2).
- Install and configure **Nginx**.
- Create and deploy a static website.
- Automate deployment using `rsync` and a `deploy.sh` script.

---

## 📁 Project Structure

static-site/
├── index.html
├── style.css
└── deploy.sh

yaml
Copy
Edit

---

## ⚙️ Prerequisites

- AWS EC2 Ubuntu instance
- Two SSH keys (`bastion-host.pem`, `second-key`)
- Static site files (HTML, CSS, etc.)
- rsync installed (`brew install rsync` on macOS)

---

## 🔧 EC2 Server Setup (One-Time)

1. **SSH into your EC2 server** using your private key:

   ```bash
   ssh -i ~/.ssh/bastion-host.pem ubuntu@<EC2-PUBLIC-IP>
Install Nginx:

bash
Copy
Edit
sudo apt update
sudo apt install nginx -y
Start and enable Nginx:

bash
Copy
Edit
sudo systemctl start nginx
sudo systemctl enable nginx
Set up the static site directory:

bash
Copy
Edit
sudo mkdir -p /var/www/static-site
sudo chown -R $USER:$USER /var/www/static-site
Configure Nginx:

bash
Copy
Edit
sudo nano /etc/nginx/sites-available/static-site
Paste the following configuration:

nginx
Copy
Edit
server {
    listen 80;
    server_name _;
    root /var/www/static-site;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }
}
Enable your config and disable default:

bash
Copy
Edit
sudo ln -s /etc/nginx/sites-available/static-site /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
Test and reload Nginx:

bash
Copy
Edit
sudo nginx -t
sudo systemctl reload nginx
📤 Deployment Script
Create a file called deploy.sh in your static-site project folder:

bash
Copy
Edit
#!/bin/bash

REMOTE_USER=ubuntu
REMOTE_HOST=13.48.13.51
REMOTE_PATH=/var/www/static-site
SSH_KEY=~/.ssh/second-key

echo "📤 Deploying files to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH..."
rsync -avz --exclude 'deploy.sh' -e "ssh -i $SSH_KEY" ./ $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH
echo "✅ Deployment complete! Visit: http://$REMOTE_HOST"
Make it executable:

bash
Copy
Edit
chmod +x deploy.sh
🚀 Deploying Changes
Anytime you make changes to your static site files, run:

bash
Copy
Edit
./deploy.sh
✅ Output Example
csharp
Copy
Edit
📤 Deploying files to ubuntu@13.48.13.51:/var/www/static-site...
Transfer starting: 3 files
./
index.html
style.css
✅ Deployment complete! Visit: http://13.48.13.51

This is the project link: https://roadmap.sh/projects/static-site-server
