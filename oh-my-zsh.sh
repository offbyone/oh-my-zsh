# Initializes Oh My Zsh

# add a function path
fpath=($ZSH/functions $fpath)

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ( $ZSH/lib/*.zsh(.N) ) source $config_file

# Load all of the custom paths; these are needed for later
for config_file ( $ZSH/paths/*.zsh(.N) ) source $config_file

# Load all of your custom configurations from custom/
for config_file ( $ZSH/custom/*.zsh(.N) ) source $config_file

# Load all of the plugins that were defined in ~/.zshrc
plugin=${plugin:=()}
for plugin ($plugins); do
    if [[ -r $ZSH/plugins/$plugin/$plugin.plugin.zsh ]]; then
        source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    elif [[ $WARN_ON_MISSING_PLUGINS != "false" ]]; then
        echo "WARNING: Missing plugin $plugin"
    fi
done

# Load the theme
source "$ZSH/themes/$ZSH_THEME.zsh-theme"

# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" = "true" ]
then
  return
else
  /usr/bin/env zsh $ZSH/tools/check_for_upgrade.sh
fi
