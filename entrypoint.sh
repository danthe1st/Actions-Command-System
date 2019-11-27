#!/bin/sh -l

echo "get $1"
curl -L "$1" > run.jar
java -jar run.jar
