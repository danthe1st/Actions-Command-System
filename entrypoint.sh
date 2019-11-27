#!/bin/sh -l

#echo "get $1"
#curl -L "$1" > run.jar
#java -jar run.jar

echo 'setting PATH'
PATH="$PATH:/lib"
echo "set PATH to $PATH"

SKIP=0
PREFIX="/"
echo "if"
if [[ $str == ${PREFIX}* ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
