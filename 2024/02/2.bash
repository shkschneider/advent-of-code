#!/usr/bin/env bash

t0="$(date -u +%s%N)"

reports() {
	local levels=("$@")
	local n1=${levels[0]}
	local n2=${levels[1]}
	local ascending
	if (( n1 < n2 )) ; then
		ascending=true
	elif (( n1 > n2 )) ; then
		ascending=false
	else
		return 1
	fi
	local len=${#levels[@]}
	local i
	for (( i = 1 ; i < len ; i++)) ; do
		local previous=${levels[i - 1]}
		local current=${levels[i]}
		local diff=$(( previous - current ))
		local distance=${diff#-}
		if (( distance < 1 || distance > 3 )) ; then
			return 1
		fi
		# unsafe
		if $ascending && (( previous > current )) ; then
			return 1
		elif ! $ascending && (( previous < current )) ; then
			return 1
		fi
	done
	return 0
}

r=0
while read -ra levels ; do
	if reports "${levels[@]}"; then
		(( r++ ))
	else
	    # unsafe
		len=${#levels[@]}
		for (( i = 0 ; i < len ; i++ )) ; do
			j=$((i+1))
			slice=("${levels[@]:0:i}" "${levels[@]:j}")
			if reports "${slice[@]}"; then
				(( r++ ))
				break
			fi
		done
	fi
done

echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
