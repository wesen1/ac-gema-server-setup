#!/bin/bash

# Copy all *.example files to the productive file paths if required
find "$REPOSITORY_ROOT" -type f -name "*.example" -print0 | while read -d $'\0' exampleFilePath
do
  productiveFilePath=${exampleFilePath%.example}
  if [ ! -f "$productiveFilePath" ]; then
    echo "Creating ${productiveFilePath#$REPOSITORY_ROOT/} from example ..."
    cat "$exampleFilePath" | envsubst > "$productiveFilePath"
  fi
done


# Update all config files from the *.template files
find "$REPOSITORY_ROOT" -type f -name "*.template" -print0 | while read -d $'\0' templateFilePath
do
  productiveFilePath=${templateFilePath%.template}
  echo "Updating ${productiveFilePath#$REPOSITORY_ROOT/} from template ..."
  cat "$templateFilePath" | envsubst > "$productiveFilePath"
done
