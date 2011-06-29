if [[ $EMACS == t ]]; then
    term=ansi
else
    term=$TERM
fi

eval `TERM=$term dircolors $ZSH/lib/dircolors-solarized`
