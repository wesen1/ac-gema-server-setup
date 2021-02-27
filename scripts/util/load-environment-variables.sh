#!/bin/bash

# Load the variables from .env
if [ ! -f "$REPOSITORY_ROOT/.env" ]; then
  cp "$REPOSITORY_ROOT/.env.example" "$REPOSITORY_ROOT/.env"
fi
export $(cat "$REPOSITORY_ROOT/.env" | xargs)
