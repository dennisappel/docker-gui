#!/bin/bash

CRED_FILE="$1"

HOSTDIR=$(pwd)
WORKDIR="/results"

eog screen.png &
EOG=$!

BIN_DIR="/gui"

BIN=""
CONN=""
CLNT=""
USER=""
PASS=""
LANG=""
GUI_ARGS=""

if [ -f "$CRED_FILE" ]; then
  source "$CRED_FILE"
fi

docker run --rm  \
  -e GUI_ARGS="$GUI_ARGS" \
  -e BIN_DIR="$BIN_DIR" \
  -e BIN="$BIN" \
  -v $HOSTDIR:$WORKDIR sap-test

