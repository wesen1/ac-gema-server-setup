#!/bin/bash

# Make sure that the database container is running

docker-compose run database mysqldump -u root -p{DATABASE_ROOT_PASSWORD} {DATABASE_NAME} > created-backup.sql
