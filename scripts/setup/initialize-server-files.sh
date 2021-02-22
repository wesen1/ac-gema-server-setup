#!/bin/bash

# Make sure that the server packages exist
if [ ! -d "$REPOSITORY_ROOT/shared-data/packages" ]; then
  echo "Downloading AssaultCube ..."

  archiveFilePath="$REPOSITORY_ROOT/tmp/AssaultCube_v1.2.0.2.tar.bz2"
  archiveMainDirectoryName="AssaultCube_v1.2.0.2"
  outputDirectory="$REPOSITORY_ROOT/shared-data"

  wget https://github.com/assaultcube/AC/releases/download/v1.2.0.2/AssaultCube_v1.2.0.2.tar.bz2 -P "$REPOSITORY_ROOT/tmp"

  filesToExtract=(
    # Extract the default server packages
    "$archiveMainDirectoryName/packages/audio/ambience"
    "$archiveMainDirectoryName/packages/maps"
    "$archiveMainDirectoryName/packages/models/mapmodels"
    "$archiveMainDirectoryName/packages/textures"
  )

  mkdir -p "$outputDirectory"
  tar -xvf "$archiveFilePath" -C "$outputDirectory/" --strip-components=1 "${filesToExtract[@]}" --keep-old-files

  rm "$archiveFilePath"
fi
