#
# INSTRUCTIONS
#
#   To enabled agent forwarding support add the following to
#   your .zshrc file:
#
#     zstyle :omz:plugins:ssh-agent-midway agent-forwarding on
#
#   To load multiple identies use the identities style, For
#   example:
#
#     zstyle :omz:plugins:ssh-agent-midway identities id_rsa id_rsa2 id_github
#
#
# CREDITS
#
#   Based on code from Joseph M. Reagle
#   http://www.cygwin.com/ml/cygwin/2001-06/msg00537.html
#
#   Agent forwarding support based on ideas from
#   Florent Thoumie and Jonas Pfenniger
#

local _plugin__ssh_env=$HOME/.ssh/midway-environment-$HOST
local _plugin__forwarding

zstyle :omz:plugins:ssh-agent-midway agent-forwarding on

kernel=`uname -s`
if [ $kernel  = "Darwin" ]
then
  SCSSH_PATH=/opt/midway/bin
  SCSSH_LIB=/Library/Frameworks/eToken.framework/Versions/Current/libeToken.dylib
else
  SCSSH_PATH=/apollo/env/MidwayClient/bin
  SCSSH_LIB=/usr/lib64/libeToken.so
fi

export SCSSH_PATH
export SCSSH_LIB

function _plugin__start_agent()
{
  local -a identities

  # start ssh-agent and setup environment
  /usr/bin/env $SCSSH_PATH/ssh-agent | sed 's/^echo/#echo/' > ${_plugin__ssh_env}
  chmod 600 ${_plugin__ssh_env}
  . ${_plugin__ssh_env} > /dev/null

  # load identies
  zstyle -a :omz:plugins:ssh-agent-midway identities identities
  echo starting...
  $SCSSH_PATH/ssh-add $HOME/.ssh/${^identities}
  $SCSSH_PATH/ssh-add -s $SCSSH_LIB
}

# test if agent-forwarding is enabled
zstyle -b :omz:plugins:ssh-agent-midway agent-forwarding _plugin__forwarding
if [[ ${_plugin__forwarding} == "yes" && -n "$SSH_AUTH_SOCK" ]]; then
  # Add a nifty symlink for screen/tmux if agent forwarding
  [[ -L $SSH_AUTH_SOCK ]] || ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-midway-$USER-screen

elif [ -f "${_plugin__ssh_env}" ]; then
  # Source SSH settings, if applicable
  . ${_plugin__ssh_env} > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    _plugin__start_agent;
  }
else
  _plugin__start_agent;
fi

alias scadd='$SCSSH_PATH/ssh-add -s $SCSSH_LIB'
alias scscp='$SCSSH_PATH/scp -o PKCS11Provider=$SCSSH_LIB'
alias scssh='$SCSSH_PATH/ssh -I $SCSSH_LIB'

# tidy up after ourselves
unfunction _plugin__start_agent
unset _plugin__forwarding
unset _plugin__ssh_env
