#!/bin/bash

PATH="$PATH:/lib"

SKIP=0
prefix="/"

text=`jq -r ".comment.body" "$GITHUB_EVENT_PATH"`

echo "does $text start with $prefix ?"
echo "if [[ $text == ${prefix}* ]]; then"
if [[ $text == ${prefix}* ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
