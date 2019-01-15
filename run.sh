#!/usr/bin/env bash

function indent() {
  while read line; do
    echo '    ' $line
  done
}

# Remove data if present
echo " --> Removing old data"
[ -d "./radata" ] && rm -rf ./radata
[ -d "./data"   ] && rm -rf ./data
[ -d "./ossl"   ] && rm -rf ./ossl

# Run local version (expected behavior)
echo " --> Showing expected behavior"
node local | indent

# Remove data (to ensure a clean environment)
echo " --> Removing data again"
[ -d "./radata" ] && rm -rf ./radata
[ -d "./data"   ] && rm -rf ./data
[ -d "./ossl"   ] && rm -rf ./ossl

# Start the processes
echo " --> Showing unexpected behavior"
node server | indent & SERVER=$!
node client | indent & CLIENT=$!

# Wait for the child to finish
wait $CLIENT

# Kill the server
kill $SERVER

# Data not removed here, to allow inspection
