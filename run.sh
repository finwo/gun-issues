#!/usr/bin/env bash

# Remove data if present
echo "Removing old data"
[ -d "./radata" ] && rm -rf ./radata
[ -d "./data"   ] && rm -rf ./data
[ -d "./ossl"   ] && rm -rf ./ossl

# Start the processes
echo "Starting processes"
node server & SERVER=$!
node client & CLIENT=$!

# Wait for the child to finish
wait $CLIENT

# Kill the server
kill $SERVER
