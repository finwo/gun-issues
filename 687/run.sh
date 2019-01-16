#!/usr/bin/env bash

# Ensure we're in the right wd
cd $(dirname $0)

# Make sure we have all dependencies
[ -z "$SKIPDEP" ] && {
  NPM=$( command -v pnpm &>/dev/null && echo "pnpm recursive" || echo "npm" );
  $NPM install
}

# Helper function for indenting
function indent() {
  while IFS= read line; do
    echo "     $line"
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
node server | indent &
node client | indent &

# Wait for the child to finish
wait %2
# Kill the server
kill %1

# Data not removed here, to allow inspection
