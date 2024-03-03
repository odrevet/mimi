#!/bin/bash

tojson() {
    declare -n v=$1
    printf '%s\0' "${!v[@]}" "${v[@]}" |
    jq -Rs 'split("\u0000") | . as $v | (length / 2) as $n | reduce range($n) as $idx ({}; .[$v[$idx]]=$v[$idx+$n])'
}

declare -A info_array

while IFS= read -r line; do
    key="${line%%:*}"
    value="${line#*: }"

    if [ -z "$value" ]; then
        value="null"
    fi

    info_array["$key"]="$value"
done <<< $(mocp -i)

echo "Content-type: application/json"
echo ""
tojson info_array
