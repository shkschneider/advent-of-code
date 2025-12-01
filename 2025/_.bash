#!/usr/bin/env bash

t0="$(date -u +%s%N)"

# ...

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
