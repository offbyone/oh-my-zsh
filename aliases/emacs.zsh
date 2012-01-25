if [[ $EMACS = t ]]; then
    export EDITOR=emacsclient
    export VISUAL=emacsclient
    export PAGER=cat
    alias emacs='emacsclient'
    alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudoedit"
else
    export EDITOR=${EDITOR:-emacs}
    export VISUAL=${VISUAL:-emacs}
    export PAGER=${PAGER:-less}
    alias E=sudoedit
fi
