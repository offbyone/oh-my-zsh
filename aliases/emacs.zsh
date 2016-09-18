export ALTERNATE_EDITOR="$HOME/scripts/emacs-daemon"
export GIT_EDITOR="$EDITOR"
if [[ ! -z $INSIDE_EMACS ]]; then
    export PAGER=cat
    export EDITOR=emacsclient
else
    export PAGER=${PAGER:-less}
    export EDITOR=emacs
fi

export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
