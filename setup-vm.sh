#!/bin/bash
set -e

echo "=== Hermes VM Setup ==="

# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    echo "Docker installed. You may need to log out and back in for group changes."
fi

# Install Docker Compose plugin
if ! docker compose version &> /dev/null; then
    echo "Installing Docker Compose plugin..."
    sudo apt-get install -y docker-compose-plugin
fi

# Create project directory
sudo mkdir -p /opt/hermes
sudo chown $USER:$USER /opt/hermes

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Clone your repos into /opt/hermes/"
echo "     cd /opt/hermes"
echo "     git clone <exodus-repo> exodus"
echo "     git clone <muse-repo> muse"
echo "     git clone <progression-repo> progression"
echo "     git clone <sisyphus-repo> sisyphus"
echo "     git clone https://github.com/plastic-labs/honcho.git honcho"
echo "     git clone <hermes-deploy-repo> deploy"
echo ""
echo "  2. Create .env file"
echo "     cp /opt/hermes/deploy/.env.example /opt/hermes/deploy/.env"
echo "     nano /opt/hermes/deploy/.env  # fill in real values"
echo ""
echo "  3. Start everything"
echo "     cd /opt/hermes/deploy"
echo "     docker compose -f docker-compose.prod.yml up -d --build"
echo ""
echo "  5. (Optional) Set up SSL"
echo "     docker compose -f docker-compose.prod.yml run --rm certbot certonly \\"
echo "       --webroot -w /var/www/certbot -d YOUR_DOMAIN"
echo "     # Then uncomment the HTTPS block in nginx.conf and restart nginx"
