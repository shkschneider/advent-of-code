#!/usr/bin/env bash

c=50
r=0

while read -r line ; do
	d=${line:0:1}
	n=${line:1}
	m=0
	case "$d" in
		L)
			for (( i = 0 ; i < n ; i++ )) ; do
				(( c -= 1 ))
				if (( c == 0 )) ; then
					(( r++ ))
				fi
				if (( c < 0 )) ; then
					(( c += 100 ))
				fi
			done
			;;
		R)
			for (( i = 0 ; i < n ; i++ )) ; do
				(( c += 1 ))
				if (( c >= 100 )) ; then
					(( c -= 100 ))
				fi
				if (( c == 0 )) ; then
					(( r++ ))
				fi
			done
			;;
		*) exit 1 ;;
	esac
done
echo

echo "$r"
