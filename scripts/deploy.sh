#!/bin/bash

# Login to GitHub Container Registry
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_ACTOR" --password-stdin
# Pull latest deployment config from GitHub
git pull origin master
# Pull latest images from GitHub Container Registry
docker compose pull
# Migrate db schema changes
docker compose run api npx prisma migrate deploy
# Start/restart containers with new images
docker compose up -d
./scripts/health-checker.sh
