mocp --stop
mocp --clear
shuf -n 32 --random-source=/dev/urandom musics_list.txt | xargs -d '\n' mocp -a
mocp --play