#!/bin/bash

# Parse the arguments
backupFileName="$1"

# Initialize
REPOSITORY_ROOT="$(dirname $0)/../"
. "$REPOSITORY_ROOT/scripts/util/load-environment-variables.sh"

# Check if the backup file exists
backupDirectoryPath="$REPOSITORY_ROOT/database_backups"
backupFilePath="$backupDirectoryPath/$backupFileName"
if [ ! -f "$backupFilePath" ]; then
  echo "ERROR: File \"$backupFilePath\" not found in $backupDirectoryPath"
  exit 1
fi

# Make sure that the database container is running
(cd "$REPOSITORY_ROOT"; docker-compose up -d database)


# Restore the backup
if [[ "$backupFileName" == data_backup_* ]]; then
  printf "Restoring data backup \"$backupFilePath\" ... "
else
  printf "Restoring database backup \"$backupFilePath\" ... "
fi

mysqlCommand="mysql -u $DATABASE_USER -p$DATABASE_PASSWORD $DATABASE_NAME < /backup.sql"

absoluteBackupFilePath="$(realpath $(pwd)/$backupFilePath)"
(cd "$REPOSITORY_ROOT"; docker-compose run --rm -v $absoluteBackupFilePath:/backup.sql database bash -c "$mysqlCommand")
printf "OK\n"
