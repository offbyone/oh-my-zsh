function is_local_fs() {
    local dir="${1:-$(pwd)}";

    local local_root=$(df -l "$dir" | awk '/^Filesystem/ {next}; {print $6}')

    if [[ -n $local_root ]]; then
        return 0
    else
        return 1
    fi
}
