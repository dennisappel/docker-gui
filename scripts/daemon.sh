#!/bin/bash

FILENAME="transaction.json"
SCRIPT="/scripts/runtransaction.py"

wait_for_file() {
	until [ -f "$FILENAME" ]
	do
		sleep 5
	done
	echo "Transaction found..."
}

main() {
	while true
	do
		wait_for_file
		echo "Running transaction..."
		touch result.json
		python3 "$SCRIPT"
		chmod 666 result.json
		mv transaction.json transaction1.json
	done
}

main
