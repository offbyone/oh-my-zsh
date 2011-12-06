for ext in $HOME/extensions/git*; do
    prepend_path PATH $ext;
done

export PATH
