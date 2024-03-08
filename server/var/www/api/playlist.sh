entries=()
while IFS= read -r line; do
    if [[ "$line" == \#* ]]; then
        continue  # Ignore commented lines
    fi
    entries+=("$line")
done < "/home/player/.moc/playlist.m3u"

echo "Content-type: application/json"
echo ""
jq -c -n '$ARGS.positional' --args "${entries[@]}"
