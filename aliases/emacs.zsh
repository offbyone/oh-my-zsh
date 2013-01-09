export ALTERNATE_EDITOR="$HOME/scripts/emacs-daemon"
export EDITOR="$HOME/scripts/editor"
export VISUAL="$HOME/scripts/editor"
alias emacs=$HOME/scripts/editor
if [[ $EMACS = t ]]; then
    export PAGER=cat
else
    export PAGER=${PAGER:-less}
fi
