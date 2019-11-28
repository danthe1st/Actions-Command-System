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
prefixLen=1

text=`jq -r ".comment.body" "$GITHUB_EVENT_PATH"`

if [[ $text == ${prefix}* ]]; then
  # is command
  echo "$text is a command"
  text="${text:$prefixLen}"
  cmdName="`cut -d' ' -f1`"
  cmdName="`echo $cmdName|sed 's/[^a-zA-Z0-9]//g'`"
  args="`cut -d' ' -f2-`"
  echo "executing command $cmdName with arguents $args"
  if [-x "/commands/$cmdName" ]; then
  	bash -c "/commands/$cmdName $args" && echo "executed command successfully" || echo "command errored with exit code $?"
  else
	echo "command not existant or executable" >/dev/stderr
	exit -1
  fi
else
  echo "$text is no command - skipping"
  exit $SKIP
fi
