#!/bin/sh -l

#echo "get $1"
#curl -L "$1" > run.jar
#java -jar run.jar

export PATH=$PATH:/lib

SKIP=0
PREFIX="$1"

if [[ $str == "${PREFIX}*" ]]; then
  # is command
  echo "this is a command"
  sendAPI
else
  echo "no command - skipping"
  exit $SKIP
fi
