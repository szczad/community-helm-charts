#!/bin/ash


echo "[INFO] Waiting for MySQL/MariaDB Database to become ready..."

until nc -z -w 2 $HOST $PORT; do
  COUNT=$((COUNT + 1));
  SLEEP_TIME=$(fib $COUNT);
  echo "[WARNING] Unable to access database! Sleeping $SLEEP_TIME seconds. Waiting for $HOST to listen on $PORT...";
  sleep $SLEEP_TIME;
done;

echo "[INFO] Database OK ✓"
