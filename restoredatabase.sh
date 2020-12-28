#!/bin/bash

# Make sure that the database container is running

docker-compose run -v "$PWD/backup.sql:/backup.sql" database mysql -u root -proot assaultcube_gema -e 'DROP DATABASE assaultcube_gema; CREATE DATABASE assaultcube_gema; USE assaultcube_gema; SOURCE /backup.sql;'
