alias ll="ls -alFGh"

export CLICOLORS=YES
alias grep="grep --color=auto"

if [ -z "$TMUX" ]
then
tmux
fi

ssh () {
    if command ssh "$@" which tmux
    then
        DESTUSER=$(command ssh $@ 'echo `whoami`'|head -n 1|awk '{print $1;}')
        DESTHOST=$(command ssh $@ 'echo `hostname`'|head -n 1|awk '{print $1;}')
        tmux rename-window "$DESTUSER@$DESTHOST"
        command ssh -t "$@" tmux new -s main -A
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}
