#!/bin/bash

retries=0
max_retries=30
until curl -f http://localhost:3000/health; do
  retries=$((retries + 1))
  if [ $retries -ge $max_retries ]; then
    echo "Health check failed after $max_retries attempts"
    exit 1
  fi
  sleep 2
done
echo "Backend is healthy, deployment successful"
