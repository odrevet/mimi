source decode-params.sh
action=${params["action"]}

case "$action" in
  next)
    mocp -f
    ;;
  previous)
    mocp -r
    ;;
  toggle_pause)
    mocp --toggle-pause
    ;;
  stop)
    mocp --clear
    mocp --stop
    ;;
  forward)
    mocp -k +10
    ;;
  backward)
    mocp -k -10
    ;;
  *)
    ;;
esac

echo "Content-type: application/json"
echo ""
jq -n --arg action "$action" '{"action": $action}'
