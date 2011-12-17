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
    /usr/local/Cellar/ruby/1.9.2-p290/bin
    /usr/local/share/python
)

for d in $APPEND_PATHS; do
    [ -d $d ] && append_path PATH $d
done

for d in $PREPEND_PATHS; do
    [ -d $d ] && prepend_path PATH $d
done


# : use my binaries first
prepend_path PATH $HOME/local/bin
prepend_path PATH $HOME/bin
prepend_path PATH $HOME/scripts

# configure the manpath
prepend_path MANPATH /usr/share/man
prepend_path MANPATH /usr/local/share/man
prepend_path MANPATH /usr/local/man
prepend_path MANPATH $HOME/local/man

# Add the local lib directory to the LD_LIBRARY_PATH
prepend_path LD_LIBRARY_PATH /usr/local/lib
prepend_path LD_LIBRARY_PATH $HOME/local/lib
prepend_path LD_LIBRARY_PATH $HOME/lib
export PATH MANPATH LD_LIBRARY_PATH
