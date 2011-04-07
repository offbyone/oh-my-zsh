# : strip /usr/local/* and /opt/local/* from the paths so I can control what order it's placed in.
PATH=${PATH:-''}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-''}
MANPATH=${MANPATH:-''}

SED=`which sed`

for base (/opt/local /usr/local); do
    PATH=$(echo $PATH | $SED -e 's#:$base/bin:#:#g' -e 's#:$base/bin$##g' -e 's#^$base/bin:##g')
    LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | $SED -e 's#:$base/lib:#:#g' -e 's#:$base/lib$##g' -e 's#^$base/lib:##g')
    MANPATH=$(echo $MANPATH | $SED -e 's#:$base/man:#:#g' -e 's#:$base/man$##g' -e 's#^$base/man:##g')
done

export PATH MANPATH LD_LIBRARY_PATH
