function ensure_pythonbrew() {
    if [[ -d $HOME/.pythonbrew ]]; then
        [[ -x $HOME/.pythonbrew/bin/pythonbrew ]] && return 0
        return 1
    fi

    /usr/bin/env zsh $ZSH/plugins/pythonbrew/offer_install.zsh
    return $?
}

if ensure_pythonbrew; then
    append_path PATH $HOME/.pythonbrew/bin
    export PATH
fi
