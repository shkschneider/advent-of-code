#!/usr/bin/env bash

t0="$(date -u +%s%N)"

declare -A puzzle
r=0

check() {
	local i=$i
	local j=$j
	# \
	local c1=${puzzle["$((i-1)),$((j-1))"]}
	local c2=${puzzle["$((i+1)),$((j+1))"]}
	if [[ $c1 == "M" && $c2 == "S" ]] || [[ $c1 == "S" && $c2 == "M" ]]; then
		true
	else
		return
	fi
	# /
	local c1=${puzzle["$((i-1)),$((j+1))"]}
	local c2=${puzzle["$((i+1)),$((j-1))"]}
	if [[ $c1 == "M" && $c2 == "S" ]] || [[ $c1 == "S" && $c2 == "M" ]]; then
		(( r++ ))
	fi
}

height=0
width=0
while read -r line ; do
    width=${#line}
	for (( j = 0 ; j < width ; j++ )) ; do
		puzzle["$height,$j"]=${line:j:1}
	done
	(( height++ ))
done
for (( i = 0 ; i < height ; i++ )) ; do
	for (( j = 0 ; j < width ; j++ )) ; do
		if [[ ${puzzle["$i,$j"]} == "A" ]]; then
			check "$i" "$j"
		fi
	done
done

echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
