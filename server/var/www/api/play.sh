source decode-params.sh

shuffle=""
if [[ -v params["shuffle"] ]]; then
    shuffle="--shuffle"
fi

bash /home/player/playlist.sh --filter "${params['filter']}" --truncat 32 $shuffle
bash playlist.sh
