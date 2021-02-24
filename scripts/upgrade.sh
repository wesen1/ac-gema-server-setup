#!/bin/bash

# Exit when any command fails
set -e

# Set up the required variables

# Argument $0 is the path to this script relative from the current working directory
export REPOSITORY_ROOT="$(dirname $0)/../"
. "$REPOSITORY_ROOT/scripts/load-environment-variables.sh"

# Make sure that the required server files exist
"$REPOSITORY_ROOT/scripts/setup/initialize-server-files.sh"

# Stop all running containers
docker-compose -f "$REPOSITORY_ROOT/docker-compose.yaml" stop

# Now back up the old logs before the containers are destroyed
"$REPOSITORY_ROOT/scripts/backup-logs.sh"

# Destroy the containers
docker-compose -f "$REPOSITORY_ROOT/docker-compose.yaml" down

# Pull latest changes from the git repository
git pull origin main

# Update the docker images to the latest available versions
docker-compose pull

# Update the config files with the latest templates
"$REPOSITORY_ROOT/scripts/setup/update-config-files.sh"

if [[ "$1" != "-h" && "$1" != "--halt" ]]; then
  docker-compose up -d
fi
