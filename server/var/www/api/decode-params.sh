function url_decode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

declare -A params
IFS='&' read -ra pairs <<< "$QUERY_STRING"
for pair in "${pairs[@]}"; do
  IFS='=' read -r key value <<< "$pair"
  decoded_value=$(url_decode "$value")
  params["$key"]="$decoded_value"
done
