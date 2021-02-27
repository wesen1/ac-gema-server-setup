#!/bin/bash

# Initialize if required
if [[ -z "$REPOSITORY_ROOT" ]]; then
  REPOSITORY_ROOT="$(dirname $0)/../"
  . "$REPOSITORY_ROOT/scripts/util/load-environment-variables.sh"
  . "$REPOSITORY_ROOT/scripts/util/functions.sh"
fi

# Find a unique file to write the backup to
logsDirectoryPath="$REPOSITORY_ROOT/log_backups"
if [ ! -d "$logsDirectoryPath" ]; then
  mkdir "$logsDirectoryPath"
fi
logBackupFilePath="$(getUniqueFilePath $logsDirectoryPath log_backup_)"

# Backup the logs
printf "Creating log backup ... "
(cd "$REPOSITORY_ROOT"; docker-compose logs -t --no-color > "$logBackupFilePath")
printf "OK\n"
