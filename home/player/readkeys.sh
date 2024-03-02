#!/usr/bin/env bash

interrupt_handler() {
  echo "Interrupt signal received"
  if [ -n "$SSH_CLIENT" ]; then
      exit 1
  fi
}

trap interrupt_handler INT TERM HUP QUIT SIGTSTP STOP

read_key() {
  if read -sN1 key; then
    while read -sN1 -t 0.001 ; do
      key+="${REPLY}"
    done
  fi
}

read_filter() {
  play -n synth 0.1 sine 340
  read -r filter
  bash fuzzy-playlist.sh $filter $1 $2
}


while read_key; do
  case "${key}" in
    $'f'|$'\eOP'|$'\E[[A') read_filter 96;;         # f or F1
    $'\006'|$'\eOQ'|$'\E[[B') read_filter 32 1;;    # ctrl-f or F2
    $'p') mocp --toggle-pause;;
    $'\020') sh poweroff.sh;;  #ctrl-p
    $'r') bash random-playlist.sh;;
    $'\E[A') mocp -r;;      # arrow up
    $'\E[B') mocp -f;;      # arrow down
    $'\E[C') mocp -k +10;;  # arrow right
    $'\E[D') mocp -k -10;;  # arrow left
    *) printf %q\\n "$key";;
  esac
done
