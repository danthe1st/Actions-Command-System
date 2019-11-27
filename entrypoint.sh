#!/bin/sh -l

echo "get $1"
curl "$1" > run.jar
ls
file run.jar
java -jar run.jar
