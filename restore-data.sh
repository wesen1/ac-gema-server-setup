#!/bin/bash

# Make sure that the database container is running

docker-compose run -v "$PWD/backup.sql:/backup.sql" database mysql -u root -proot assaultcube_gema < ./created-backup.sql
