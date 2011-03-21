function set_environment() {
    env_name=${1:-other}
    CR_ENVIRONMENT_SELECTION=$env_name
    export CR_ENVIRONMENT_SELECTION
    reload
}

function set_default_environment() {
    unset CR_ENVIRONMENT_SELECTION
    export CR_ENVIRONMENT_SELECTION
    reload
}

function get_env_name () {
    local forced_env=${CR_ENVIRONMENT_SELECTION:-xxx}
    if [ "$forced_env" != "xxx" ]; then
        echo $forced_env
        return
    fi

    hostname=${1:-`hostname`}
    case $hostname in
        void.* | null.*)
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
