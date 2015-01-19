function is_local_fs() {
    local dir="${1:-$(pwd)}";

    local local_root=$(df -l "$dir" | awk 'BEGIN {offset=6};
/^Filesystem/ {next};
NF == 1 {offset=5; next};
{print $offset}')

    if [[ -n $local_root ]]; then
        return 0
    else
        return 1
    fi
}
