#!/bin/bash

# Login to GitHub Container Registry
echo ${{ secrets.GITHUB_TOKEN }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
# Pull latest deployment config from GitHub
git pull origin master
# Pull latest images from GitHub Container Registry
docker compose pull
# Migrate db schema changes
docker compose run backend prisma migrate deploy
# Start/restart containers with new images
docker compose up -d
./health-checker.sh
