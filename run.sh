#!/usr/bin/env bash

FAIL=0

# Start the processes
node server &
node client &

for job in `jobs -p`; do
  echo $job
  wait $job || let "FAIL+=1"
done

echo $FAIL
