export APOLLO_ENV=/apollo/env
if [[ -d $APOLLO_ENV ]]; then
    #################### important pre-external-hook vars ################
    # path where zsh searches for modules (such as zle, the zsh line editor)
    # you *want* this to work
    module_path=($ENV_IMPROVEMENT_ROOT/var/lib/zsh/$ZSH_VERSION/)

    # search path for zsh functions  (fpath ==> function path)
    # Make sure the AmazonZshFunctions list comes second for overriding reasons
    fpath=(                                                         \
        $ENV_IMPROVEMENT_ROOT/var/zsh/functions/$ZSH_VERSION        \
        $ENV_IMPROVEMENT_ROOT/var/share/zsh/$ZSH_VERSION/functions  \
	)
fi
