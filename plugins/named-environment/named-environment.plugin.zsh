unset ENVIRONMENT_NAME_CACHE

function set_environment() {
    env_name=${1:-other}
    ENVIRONMENT_NAME_CACHE=$env_name
    export ENVIRONMENT_NAME_CACHE
}

function set_default_environment() {
    unset ENVIRONMENT_NAME_CACHE
    export ENVIRONMENT_NAME_CACHE
}

function get_env_name () {
    local forced_env=${ENVIRONMENT_NAME_CACHE:-xxx}
    if [ "$forced_env" != "xxx" ]; then
        echo $forced_env
        return
    fi

    if [ -f $HOME/.zsh-env-name ]; then
        forced_env=$(cat $HOME/.zsh-env-name)
        echo $forced_env
        return
    fi

    hostname=${1:-`hostname`}
    case $hostname in
        void* | null*)
            loc='home.personal'
            ;;
        chris-rose.ims.advanis.ca | chris-rose.local)
            loc='work.personal'
            ;;
        d-*.advanis.ca | ferret.advanis.ca)
            loc='work.test'
            ;;
        qa-*.advanis.ca)
            loc='work.qa'
            ;;
        *.advanis.ca)
            loc='work.production'
            ;;
        *)
            loc='other'
            ;;
    esac
    echo $loc
}

set_environment `get_env_name`
