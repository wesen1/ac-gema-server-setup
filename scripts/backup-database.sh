#!/bin/bash

# Parse the arguments
if [[ "$1" == "--only-data" ]]; then
  backupOnlyData=1
else
  backupOnlyData=0
fi


# Initialize if required
if [[ -z "$REPOSITORY_ROOT" ]]; then
  REPOSITORY_ROOT="$(dirname $0)/../"
  . "$REPOSITORY_ROOT/scripts/util/load-environment-variables.sh"
  . "$REPOSITORY_ROOT/scripts/util/functions.sh"
fi


# Make sure that the database container is running
(cd "$REPOSITORY_ROOT"; docker-compose up -d database)


# Create the database backups directory path if required
databaseBackupsPath="$REPOSITORY_ROOT/database_backups/"
if [ ! -d "$databaseBackupsPath" ]; then
  mkdir -p "$databaseBackupsPath"
fi

# Find a unique file to write the backup to
if [[ $backupOnlyData == 1 ]]; then
  fileNamePrefix="data_backup_"
else
  fileNamePrefix="database_backup_"
fi
databaseBackupFilePath="$(getUniqueFilePath $databaseBackupsPath $fileNamePrefix)"


# Create the backup
printf "Creating database backup ... "

mysqldumpOptions="-u root -p$DATABASE_ROOT_PASSWORD"
if [[ $backupOnlyData == 1 ]]; then
  mysqldumpOptions="--no-create-info $mysqldumpOptions"
fi

mysqldumpCommand="mysqldump $mysqldumpOptions $DATABASE_NAME"

(cd "$REPOSITORY_ROOT"; docker-compose run database $mysqldumpCommand > "$databaseBackupFilePath")
printf "OK\n"
