#!/bin/bash

#
# Returns a unique file path inside a given directory.
#
# @param string $1 The directory path to find a unique file path for
# @param string $2 The file name prefix
#
getUniqueFilePath()
{
  directoryPath="$1"
  fileNamePrefix="$2"

  # Find a unique log backup file name
  printf -v dateTimeString '%(%Y_%m_%d_%H_%M_%S)T\n' -1
  fileName="$fileNamePrefix$dateTimeString"
  uniqueFileName="$fileName"
  counter=1

  while [ -f "$directoryPath/$uniqueFileName" ]; do
    uniqueFileName="$fileName_$counter"
    counter=$(( $counter + 1 ))
  done

  echo "$directoryPath/$uniqueFileName"
}

export -f getUniqueFilePath
