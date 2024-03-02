#!/bin/bash

filter=$1
truncat=$2
shuffle=$3

musics=$(fzf -e --filter "$filter" < /home/player/musics_list.txt)

if [ -z "$musics" ]; then
    echo "No match"
    play -n synth 0.1 sine 200
    play -n synth 0.1 sine 200
    exit
fi

mocp --stop
mocp --clear

musics_count=$(echo "$musics" | wc -l)
mimic "$musics_count musics found"

if [[ -n $shuffle ]]; then
    musics=$(echo "$musics" | shuf --random-source=/dev/urandom)
else
    # sort alphabetically since fzf sort by length
    musics=$(echo "$musics" | sort)
fi

if [[ -n $truncat ]]; then
    musics=$(echo "$musics" | head -n "$truncat")
fi

echo "$musics" | xargs -d '\n' mocp -a
mocp --play
