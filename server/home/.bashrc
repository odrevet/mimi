# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# prevent ctrl-s hang up
stty -ixon

cd ~


alias emacs=qemacs

if [ -z "$SSH_CLIENT" ]; then
    # Commands to run only for non-SSH session

    # set volume
    amixer set PCM "100%"

    # start music on console server
    mocp -S

    # start web server
    sudo lighttpd -f /etc/lighttpd/lighttpd.conf

    # play a beep sound
    play -n synth 0.1 sine 312

    # read user input
    bash readkeys.sh
fi
