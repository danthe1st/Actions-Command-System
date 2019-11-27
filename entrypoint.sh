#!/bin/sh

PATH="$PATH:/lib"

SKIP=0
PREFIX="/"

text=`jq -r ".comment.body" "$GITHUB_EVENT_PATH"`

echo "$text"
if [[ $text == ${PREFIX}* ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
