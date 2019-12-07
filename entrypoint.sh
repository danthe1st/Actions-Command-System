#!/bin/bash
# This script is called whenever the action is executed
# It tests if an issue comment is a command and executes a bash script at /commands/<name> if it is a command
# exported Variables:
# - GITHUB_TOKEN: the GitHub token(see $1)
# - REPO_FULLNAME: the name of the Repository: <username>/<repo-name>
# - MESSAGE_AUTHOR: the username of the author of the comment
# - GH_EVENT_PATH: the json path in the GITHUB_EVENT_PATH where the data of the event can be found
# - API_PATH: the path where requests to the api should be sent to
# Arguments:
# - The GitHub token to be used
set -e

PATH="$PATH:/lib"
export GITHUB_TOKEN="$1"
REPO_FULLNAME="$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")"
export REPO_FULLNAME
MESSAGE_AUTHOR="$(jq -r ".comment.user.login" "$GITHUB_EVENT_PATH")"
export MESSAGE_AUTHOR


if [ "$(jq -r ".issue" "$GITHUB_EVENT_PATH")" != "null" ];then
	GH_EVENT_PATH=".issue"
	API_PATH="issues"
elif [ "$(jq -r ".pull_request" "$GITHUB_EVENT_PATH")" != "null" ] ;then
	GH_EVENT_PATH="pull_request"
	API_PATH="pulls"
else #TODO commit comments
	echo "unsupported event">/dev/stderr
	exit 1
fi
export GH_EVENT_PATH
export API_PATH

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "No token entered" >/dev/stderr
	exit 1
fi

SKIP=0
prefix="/"
prefixLen=1

text="$(jq -r ".comment.body" "$GITHUB_EVENT_PATH")"

echo "author: $MESSAGE_AUTHOR" > /dev/stderr
if [[ $text == ${prefix}* ]]; then
  # is command
  echo "$text is a command" >/dev/stderr
  text="${text:$prefixLen}" || ( echo "err stripping prefix" &&exit $?)
  cmdName="$(echo "$text" | cut -d' ' -f1)" || ( echo "err getting name" && exit $?)
  cmdName=${cmdName//\//"\\\\/"}
  #cmdName="$(echo "$cmdName" | sed 's/[^a-zA-Z0-9]//g')" || ( echo "err stripping name" && exit $? )
  args="$(echo "$text" | cut -d' ' -f2-)"|| ( echo "err getting args" && exit $?)
  echo "executing command $cmdName with arguments $args" >/dev/stderr
  if [ -x "/commands/$cmdName" ]; then
	( bash -c "/commands/$cmdName $args" && echo "executed command successfully" >/dev/stderr ) || ( code=$?; echo "command errored with exit code $code" >/dev/stderr && exit $code )
  else
	echo "command not existant or executable" >/dev/stderr
	exit $SKIP
  fi
else
  echo "$text is no command - skipping">/dev/stderr
  exit $SKIP
fi
