#!/usr/bin/env bash

t0="$(date -u +%s%N)"

declare -A allrules
while IFS='|' read -r lhs rhs ; do
	[[ -n "$lhs" ]] || break
	[[ -n "$rhs" ]] || break
	allrules["$rhs"]+="$lhs "
done

has() {
	local n=$1
	shift
	for m in "$@" ; do
		[[ "$n" == "$m" ]] && return 0
	done
	return 1
}

valid() {
	local update=("$@")
	local i
	for (( i = 0 ; i < ${#update[@]} ; i++ )) ; do
		local rules
		read -ra rules <<< "${allrules[${update[i]}]}"
		local rule
		for rule in "${rules[@]}"; do
			if has "$rule" "${update[@]:i+1}"; then
				return 1
			fi
		done
	done
	return 0
}

r=0
while IFS=',' read -ra update ; do
	if valid "${update[@]}"; then
        continue
	fi
	l=${#update[@]}
	for (( i = 0 ; i < l ; i++ )) ; do
		n=${update[i]}
		read -ra rules <<< "${allrules[$n]}"
		for (( j = i + 1 ; j < l ; j++ )) ; do
			for rule in "${rules[@]}" ; do
				check=${update[j]}
				[[ $rule == $check ]] || continue
				unset update[j]
				unset update[i]
				update=("${update[@]:0:i}" "$check" "$n" "${update[@]:i+1}")
				(( i-- ))
				continue 3
			done
		done
	done
    (( r += ${update[$(( ${#update[@]} / 2 ))]} ))
done
echo "$r"

t1="$(date -u +%s%N)"
echo "$(( (( t1-t0 ))/1000000 ))ms"
