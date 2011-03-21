ALIAS_PATH=$ZSH/aliases

if [ -d $ALIAS_PATH ]; then
    for config_file ($ALIAS_PATH/*.zsh) source $config_file
fi
