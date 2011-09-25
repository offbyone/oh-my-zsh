append_path PATH /Developer/Tools
append_path PATH /Developer/usr/bin
append_path PATH /Applications
append_path PATH /usr/local/mysql/bin
append_path PATH /Library/PostgreSQL8/bin
prepend_path PATH /usr/local/sbin
prepend_path PATH /usr/local/bin
prepend_path PATH /usr/local/share/python

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
