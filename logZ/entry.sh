#!/usr/bin/env bash

if [ ! -f /usr/bin/curl ]; then 
  apt install -y curl 
fi

QUERY='{"follow":true,"all":true,"format":"short-unix"}'
URL="$BALENA_SUPERVISOR_ADDRESS/v2/journal-logs?apikey=$BALENA_SUPERVISOR_API_KEY"

curl -sS -X POST -H "Content-Type: application/json" --no-buffer --data $QUERY $URL \
	| /fluent-bit/bin/fluent-bit -c /logz/fluent-bit.conf
