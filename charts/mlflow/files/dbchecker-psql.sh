#!/bin/sh

set -eu

echo "[INFO] Waiting for Database to become ready..."

export HOST="${HOST:-"localhost"}"
export PORT="${PORT:-"5432"}"
export TOTAL_TIMEOUT="${TOTAL_TIMEOUT:-"30"}"
export TIMEOUT="${TIMEOUT:-"2"}"
export SLEEP_TIME="${SLEEP_TIME:-"2"}"

# COUNT=0
# until nc -z -w "$TIMEOUT" "$HOST" "$PORT"; do
#   COUNT=$((COUNT + 1));
#   SLEEP_TIME=$(fib "$COUNT");
#   echo "[WARNING] Unable to access database! Sleeping $SLEEP_TIME seconds. Waiting for $HOST to listen on $PORT...";
#   sleep "$SLEEP_TIME";
# done

if timeout "${TOTAL_TIMEOUT}s" sh -c 'until nc -z -w "$TIMEOUT" "$HOST" "$PORT"; do echo "[WARNING] Unable to access database! Sleeping $SLEEP_TIME seconds. Waiting for $HOST to listen on $PORT..."; sleep "${SLEEP_TIME}"; done'; then
  echo "[INFO] Database OK ✓"
else 
  echo "[INFO] Database FAILED  "
  exit 1
fi
