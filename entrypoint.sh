#!/bin/sh -l

echo "get $1"
wget curl "$1" > run.jar
java -jar "$1"
