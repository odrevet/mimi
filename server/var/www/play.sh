source decode-params.sh
filter=${params["filter"]}

bash /home/player/playlist.sh --filter $filter --truncat 32

echo "Content-type: application/json"
echo ""
jq -n --arg filter "$filter" '{"filter": $filter}'
