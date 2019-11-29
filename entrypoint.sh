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
  text="${text:$prefixLen}"|| ( echo "err stripping prefix" &&exit $?)
  cmdName="`echo $text|cut -d' ' -f1`"|| ( echo "err getting name" &&exit $?)
  cmdName="`echo $cmdName|sed 's/[^a-zA-Z0-9]//g'`"|| ( echo "err stripping name" &&exit $?)
  args="`echo $text|cut -d' ' -f2-`"|| ( echo "err getting args" &&exit $?)
  echo "executing command $cmdName with arguments $args"
  if [ -x "/commands/$cmdName" ]; then
	bash -c "/commands/$cmdName $args" && echo "executed command successfully" || ( echo "command errored with exit code $?" && exit $? )
  else
	echo "command not existant or executable" >/dev/stderr
	exit -1
  fi
else
  echo "$text is no command - skipping"
  exit $SKIP
fi
