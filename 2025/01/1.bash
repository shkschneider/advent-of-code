#!/usr/bin/env bash

t0="$(date -u +%s%N)"

c=50
r=0

while read -r line ; do
	d=${line:0:1}
	n=${line:1}
	case "$d" in
		L)
			((c -= n))
			while ((c < 0)) ; do
				((c += 100))
			done
			;;
		R)
			((c += n))
			while ((c >= 100)) ; do
				((c -= 100))
			done
			;;
		*) exit 1 ;;
	esac
	if ((c == 0)); then
		((r++))
	fi
done

echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
