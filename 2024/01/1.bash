#!/usr/bin/env bash

t0="$(date -u +%s%N)"

lhs=()
rhs=()
while read -r n1 n2; do
	lhs+=("$n1")
	rhs+=("$n2")
done

mapfile -t left < <(printf '%d\n' "${lhs[@]}" | sort -n)
mapfile -t right < <(printf '%d\n' "${rhs[@]}" | sort -n)

r=0
for (( i = 0 ; i < ${#lhs[@]} ; i++ )) ; do
	diff=$((${left[$i]} - ${right[$i]}))
	(( r += ${diff#-} ))
done
echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
