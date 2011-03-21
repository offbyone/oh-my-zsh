if [ -n $EMACS ]; then
    export EDITOR=emacsclient
    export VISUAL=emacsclient
    export PAGER=cat
    alias emacs='emacsclient'
else
    export EDITOR=${EDITOR:-emacs}
    export VISUAL=${VISUAL:-emacs}
    export PAGER=${PAGER:-less}
fi
