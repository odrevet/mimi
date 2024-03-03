#!/bin/bash

declare -A info

while IFS= read -r line; do
    key="${line%%:*}"
    value="${line#*: }"

    if [ -z "$value" ]; then
        value="null"
    fi

    info["$key"]="$value"
done <<< $(mocp -i)

for key in "${!info[@]}"; do
    echo "Key: $key, Value: ${info[$key]}"
done


echo "Content-type: application/json"
echo ""
for i in "${!info[@]}"
do
    echo "$i"
    echo "${info[$i]}"
done |
jq -n -R 'reduce inputs as $i ({}; . + { ($i): (input|(tonumber? // .)) })'
