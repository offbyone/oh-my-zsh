for ext in $HOME/extensions/git*; do
    if [ -d $ext/bin ]; then
        ext=$ext/bin
    fi
    prepend_path PATH $ext;
done

export PATH
