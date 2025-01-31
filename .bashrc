# List active screen sessions if not already in a screen session
if test -z "$STY"; then
    screen -ls
fi

alias ls='ls --color --group-directories-first'
