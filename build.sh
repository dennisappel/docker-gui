#!/bin/bash

VARIABLE_FILE=""

print_usage() {
  printf "Usage: ..."
}

while getopts 'f:' flag; do
  case "${flag}" in
    f) VARIABLE_FILE="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -f "$VARIABLE_FILE" ]; then
  source "$VARIABLE_FILE"
else
  exit 1
fi

docker build \
    --build-arg JAR=$JAR \
    --build-arg JAVA_DIR=$JAVA_DIR \
    --build-arg JRE_FILE=$JRE_FILE \
    --build-arg JRE=$JRE \
    -t sap-gui .
