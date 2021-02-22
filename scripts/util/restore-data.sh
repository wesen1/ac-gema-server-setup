#!/bin/bash

# Make sure that the database container is running

docker-compose run -v "$PWD/backup.sql:/backup.sql" database mysql -u root -p{DATABASE_ROOT_PASSWORD} {DATABASE_NAME} < ./created-backup.sql
