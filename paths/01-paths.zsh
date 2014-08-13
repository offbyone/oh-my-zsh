APPEND_PATHS=(
    /Developer/Tools
    /Developer/usr/bin
    /Applications
    /usr/local/mysql/bin
    /Library/PostgreSQL8/bin
)

PREPEND_PATHS=(
    /usr/local/sbin
    /usr/local/bin
)

for d in $APPEND_PATHS; do
    [ -d $d ] && append_path PATH $d
done

for d in $PREPEND_PATHS; do
    [ -d $d ] && prepend_path PATH $d
done


# : use my binaries first
prepend_path PATH $HOME/local/bin
prepend_path PATH $HOME/.local/bin
prepend_path PATH $HOME/bin
prepend_path PATH $HOME/scripts

# configure the manpath
prepend_path MANPATH /usr/share/man
prepend_path MANPATH /usr/local/share/man
prepend_path MANPATH /usr/local/man
prepend_path MANPATH $HOME/local/man
prepend_path MANPATH $HOME/.local/man

# add $HOME/local to PKG_CONFIG_PATH
prepend_path PKG_CONFIG_PATH $HOME/local/lib/pkgconfig

# Add the local lib directory to the LD_LIBRARY_PATH
# prepend_path LD_LIBRARY_PATH /usr/local/lib
# prepend_path LD_LIBRARY_PATH $HOME/local/lib
# prepend_path LD_LIBRARY_PATH $HOME/lib
export PATH MANPATH
export PKG_CONFIG_PATH
# export LD_LIBRARY_PATH
