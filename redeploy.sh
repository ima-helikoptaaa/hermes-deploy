#!/bin/bash
set -e

# Run from /opt/hermes/deploy on the VM
# Usage: ./redeploy.sh [service]
# Examples:
#   ./redeploy.sh          # redeploy all
#   ./redeploy.sh exodus   # redeploy only exodus

cd /opt/hermes

if [ -n "$1" ]; then
    echo "Pulling $1..."
    cd /opt/hermes/$1 && git pull
else
    for repo in exodus muse progression sisyphus honcho; do
        echo "Pulling $repo..."
        cd /opt/hermes/$repo && git pull
    done
fi

cd /opt/hermes/deploy

if [ -n "$1" ]; then
    echo "Rebuilding and restarting $1..."
    docker compose -f docker-compose.prod.yml up -d --build "$1"
else
    echo "Rebuilding and restarting all services..."
    docker compose -f docker-compose.prod.yml up -d --build
fi

echo ""
echo "Done. Check status with: docker compose -f docker-compose.prod.yml ps"
