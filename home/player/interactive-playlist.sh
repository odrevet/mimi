#!/bin/bash

shuffle=$1

musics=$(fzf -e --multi --bind='ctrl-a:select-all' < musics_list.txt)

if [ -z "$musics" ]; then
    echo "No match"
    exit
fi

mocp --stop
mocp --clear

if [[ -n $shuffle ]]; then
    musics=$(echo "$musics" | shuf)
fi

echo "$musics" | xargs -d '\n' mocp -a
mocp --play