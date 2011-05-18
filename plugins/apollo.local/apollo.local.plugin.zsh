export APOLLO_ENV=/apollo/env

funcname _apollo_path_mod () {
    $1 PATH $APOLLO_ENV/$2/bin
    $1 LD_LIBRARY_PATH $APOLLO_ENV/$2/lib
    $1 MANPATH $APOLLO_ENV/$2/man
    $1 INFOPATH $APOLLO_ENV/$2/share/info

    export PATH LD_LIBRARY_PATH MANPATH INFOPATH
}

funcname env_prepend () {
    _apollo_path_mod prepend_path $1
}

func_name env_append () {
    _apollo_path_mod append_path $1
}

funcname use_apollo () {

    env_append SDETools
    env_prepend eclipse-3.6
    env_append envImprovement
    env_append Git

    #Configuration needed by perforce to function correctly in any directory
    export P4CONFIG=.p4config

    #Make SDETools use a simplified directory structure for organizing source code.
    # NOTE -- I don't want this.
    # export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short

    # GIIIIIIIT
    export BRAZIL_WORKSPACE_GITMODE=1

    export BRAZIL_COLORS=1

    # Require make to be /apollo/env/SDETools/bin/make for Brazil
    # THIS IS IMPORTANT since /usr/bin comes before /apollo/env/SDETools/bin on our path
    alias make='/apollo/env/SDETools/bin/make'

    alias ws="cd /workplace/$USER"
    export WS="/workplace/$USER"

    ######################### completion #################################
    # these are some (mostly) sane defaults, if you want your own settings, I
    # recommend using compinstall to choose them.  See 'man zshcompsys' for more
    # info about this stuff.

    # The following lines were added by compinstall

    zstyle ':completion:*' completer _expand _complete _approximate
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
    zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
    zstyle ':completion:*' menu select=long
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
    zstyle ':completion:*' use-compctl true

    if [[ $IGNORE_APOLLO_1 != 'NO' ]]
    then
      # Ignore /apollo_1 for directories.  That dir is an import directory
      zstyle ':completion:*' ignored-patterns '/apollo_1'
    fi

    # End of lines added by compinstall
}

[[ -d $APOLLO_ENV ]] && use_apollo
