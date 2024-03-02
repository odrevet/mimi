info=$(mocp -Q "%state %file")

echo "Content-type: application/json"
echo ""
jq -n --arg info "$info" '{"info": $info}'