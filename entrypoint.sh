#!/bin/sh -l

#echo "get $1"
#curl -L "$1" > run.jar
#java -jar run.jar

echo 'PATH="$PATH:/lib"'
PATH="$PATH:/lib"
echo "set path"

SKIP=0
PREFIX="/"

if [[ $str == ${PREFIX}* ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
