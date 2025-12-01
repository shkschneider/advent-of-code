#!/usr/bin/env bash

t0="$(date -u +%s%N)"

s=$(< /dev/stdin)
s=${s//)/)$'\n'}
r=0
dont=false
while read -r line ; do
    re_mul='mul\(([0-9]{1,3}),([0-9]{1,3})\)$'
    re_do='do\(\)$'
    re_dont="don't\\(\\)$"
	if [[ $line =~ $re_do ]]; then
		dont=false
	elif [[ $line =~ $re_dont ]]; then
		dont=true
	elif [[ $line =~ $re_mul ]] && ! $dont ; then
		lhs=${BASH_REMATCH[1]}
		rhs=${BASH_REMATCH[2]}
		(( r += $(( lhs * rhs )) ))
	fi
done <<< "$s"
echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
