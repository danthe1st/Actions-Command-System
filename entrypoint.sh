#!/bin/bash
set -e

PATH="$PATH:/lib"
export GITHUB_TOKEN=$1
export REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")
export MESSAGE_AUTHOR=`jq -r ".comment.user.login" "$GITHUB_EVENT_PATH"`


if [ "`jq -r ".issue" \"$GITHUB_EVENT_PATH\"`" != "null" ];then
	GH_EVENT_PATH=".issue"
	API_PATH="issues"
else if [ "`jq -r ".pull_request" \"$GITHUB_EVENT_PATH\"`" != "null" ] ;then
	GH_EVENT_PATH="pull_request"
	API_PATH="pulls"
else #TODO commit comments
	echo "unsupported event">/dev/stderr
	exit -1
fi
export GH_EVENT_PATH
export API_PATH

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "No token entered" >/dev/stderr
	exit -1
fi

SKIP=0
prefix="/"
prefixLen=1

text=`jq -r ".comment.body" "$GITHUB_EVENT_PATH"`

echo "author: $MESSAGE_AUTHOR" > /dev/stderr
if [[ $text == ${prefix}* ]]; then
  # is command
  echo "$text is a command" >/dev/stderr
  text="${text:$prefixLen}"|| ( echo "err stripping prefix" &&exit $?)
  cmdName="`echo $text|cut -d' ' -f1`"|| ( echo "err getting name" &&exit $?)
  cmdName="`echo $cmdName|sed 's/[^a-zA-Z0-9]//g'`"|| ( echo "err stripping name" &&exit $?)
  args="`echo $text|cut -d' ' -f2-`"|| ( echo "err getting args" &&exit $?)
  echo "executing command $cmdName with arguments $args" >/dev/stderr
  if [ -x "/commands/$cmdName" ]; then
	bash -c "/commands/$cmdName $args" && echo "executed command successfully" >/dev/stderr || ( echo "command errored with exit code $?" >/dev/stderr && exit $? )
  else
	echo "command not existant or executable" >/dev/stderr
	exit -1
  fi
else
  echo "$text is no command - skipping">/dev/stderr
  exit $SKIP
fi
