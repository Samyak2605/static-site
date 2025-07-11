#!/bin/bash

# Define variables
REMOTE_USER=ubuntu
REMOTE_HOST=13.48.13.51
REMOTE_PATH=/var/www/static-site
SSH_KEY=~/.ssh/second-key

# Deploy the static site using rsync
echo "📤 Deploying files to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH..."

rsync -avz --delete -e "ssh -i $SSH_KEY" ./ $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

echo "✅ Deployment complete! Visit: http://$REMOTE_HOST"
