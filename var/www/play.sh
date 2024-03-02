source decode-params.sh
filter=${params["filter"]}

bash /home/player/fuzzy-playlist.sh $filter 32

echo "Content-type: application/json"
echo ""
jq -n --arg filter "$filter" '{"filter": $filter}'
