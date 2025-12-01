#!/usr/bin/env bash

t0="$(date -u +%s%N)"

declare -A puzzle
r=0

check() {
    local s
	# check down
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a++, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check up
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a--, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check right
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; b++, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check left
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; b--, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check up-right
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a--, b++, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check down-right
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a++, b++, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check up-left
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a--, b--, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
	# check up-right
	s=""
	for (( n=0, a=i, b=j ; n < 4 ; a++, b--, n++ )) ; do
		s+="${puzzle["$a,$b"]}"
	done
	[[ $s == "XMAS" ]] && (( r++ ))
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
        check $i $j
	done
done

echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
