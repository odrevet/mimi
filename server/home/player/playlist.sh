#!/bin/bash

# Parse command line options
OPTIONS=$(getopt -o f:ist: --long filter:,interactive,shuffle,truncat: -- "$@")

# Check for errors
if [ $? -ne 0 ]; then
    echo "Usage: $(basename $0) --filter FILTER --interactive --shuffle"
    exit 1
fi

filter=""
interactive=false
shuffle=false
truncat=96

eval set -- "$OPTIONS"
while true; do
    case "$1" in
        -f | --filter) filter=$2; shift 2;;
        -i | --interactive) interactive=true; shift ;;
        -s | --shuffle) shuffle=true; shift ;;
        -t | --truncat) truncat=$2; shift 2;;
        --) shift; break ;;
        *) echo "Internal error!"; exit 1 ;;
    esac
done


if [ "$interactive" = true ]; then
    musics=$(fzf -e --multi --bind=ctrl-a:select-all < /home/player/musics_list.txt)
else
    musics=$(fzf -e --filter "$filter" < /home/player/musics_list.txt)
fi

if [ -z "$musics" ]; then
    play -n synth 0.1 sine 200
    play -n synth 0.1 sine 200
    exit
fi

mocp --stop
mocp --clear

musics_count=$(echo "$musics" | wc -l)
if [ $musics_count -eq 1 ]; then
    mimic "1 music found"
else
    mimic "$musics_count musics found"
fi

if [[ "$shuffle" = true ]]; then
    musics=$(echo "$musics" | shuf --random-source=/dev/urandom)
else
    # sort alphabetically since fzf sort by length
    musics=$(echo "$musics" | sort)
fi

if [[ -n "$truncat" ]]; then
    musics=$(echo "$musics" | head -n "$truncat")
fi

echo "$musics" | xargs -d '\n' mocp -a
mocp --play
