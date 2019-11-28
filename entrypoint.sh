#!/bin/bash
set -e

PATH="$PATH:/lib"
export GITHUB_TOKEN=$1

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "No token entered" >/dev/stderr
	exit -1
fi

SKIP=0
prefix="/"

text=`jq -r ".comment.body" "$GITHUB_EVENT_PATH"`

if [[ $text == ${prefix}* ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
