if [[ -n "$GENTOO_PREFIX" ]]; then

    prefix_paths=()

    for path_part ($path); do
        if [[ $path_part == /usr/* ]]; then
            break
        fi
        prefix_paths+=$path_part
    done

    for suffix ( usr/sbin opt/bin bin usr/bin); do
        prepend_path PATH $GENTOO_PREFIX/$suffix
    done

    for path_part (${(Oa)prefix_paths}); do
        prepend_path PATH $path_part
    done

    export PATH

fi
