#!/bin/bash

HOSTDIR=$(pwd)
WORKDIR="/results"
BIN_DIR="/gui"

CRED_FILE=""
MONITORING=false

print_usage() {
  printf "Usage: ..."
}

while getopts 'mf:' flag; do
  case "${flag}" in
    m) MONITORING=true ;;
    f) CRED_FILE="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -f "$CRED_FILE" ]; then
  source "$CRED_FILE"
else
  exit 1
fi

GUI_ARGS="$CONN&$CLNT&$USER&$PASS&$LANG"

if [ "$MONITORING" = true ]; then
eog screen.png &
fi

docker run --rm  \
  -e MONITORING="$MONITORING" \
  -e GUI_ARGS="$GUI_ARGS" \
  -e BIN="$BIN" \
  -v $HOSTDIR:$WORKDIR sap-gui
