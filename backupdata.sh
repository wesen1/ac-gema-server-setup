#!/bin/bash

# Make sure that the database container is running

docker-compose run database mysqldump --no-create-info -u root -proot assaultcube_gema > created-backup.sql
