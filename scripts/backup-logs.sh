#!/bin/bash

logsDirectoryPath="$REPOSITORY_ROOT/logs"

# Create the logs directory path if required
if [ ! -d "$logsDirectoryPath" ]; then
  mkdir "$logsDirectoryPath"
fi

# Find a unique log backup file name
printf -v dateTimeString '%(%Y-%m-%d_%H:%M:%S)T\n' -1
logBackupFileName="log_backup_$dateTimeString"
uniqueLogBackupFileName="$logBackupFileName"
counter=1

while [ -f "$uniqueLogBackupFileName" ]; do
  uniqueLogBackupFileName="$logBackupFileName_$counter"
  counter=$(( $counter + 1 ))
done

# Backup the logs
docker-compose -f "$REPOSITORY_ROOT/docker-compose.yaml" logs -t --no-color > "$logsDirectoryPath/$uniqueLogBackupFileName"
