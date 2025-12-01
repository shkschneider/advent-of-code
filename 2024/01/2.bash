#!/usr/bin/env bash

t0="$(date -u +%s%N)"

lhs=()
rhs=()
while read -r n1 n2 ; do
	lhs+=("$n1")
	rhs+=("$n2")
done

declare -A c
for n in "${rhs[@]}" ; do
	(( c[$n]++ ))
done

r=0
for v in "${lhs[@]}"; do
	f=${c[$v]}
	(( r += ((v * f)) ))
done
echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
