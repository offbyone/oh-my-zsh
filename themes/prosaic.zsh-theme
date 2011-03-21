# -*- shell-script -*-
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

function battery_charge {
    echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function get_prompt_host_color() {
    env_name=${1:-`get_env_name`}
    case $env_name in
        home.personal)
            color=$fg[green]
            ;;
        work.personal)
            color=$fg[blue]
            ;;
        work.test)
            color=$fg[green]
            ;;
        work.qa)
            color=$fg[yellow]
            ;;
        work.production)
            color=$fg_bold[red]
            ;;
        *)
            color=$fg[red]
            ;;
    esac
    echo $color
}

function get_prompt_text_color() {
    env_name=$1
    echo $fg_bold[white]
}

function get_prompt_user_color() {
    env_name=${1:-`get_env_name`}
    case $env_name in
        home.personal | work.personal)
            color=$fg[cyan]
            ;;
        work.test)
            color=$fg[green]
            ;;
        work.qa)
            color=$fg[yellow]
            ;;
        work.production)
            color=$fg[red]
            ;;
        *)
            color=$fg[red]
            ;;
    esac
    [ "$USER" = "root" ] && color=black_on_red
    echo $color
}

function hg_prompt_info {
    if [[ $(pwd) == $HOME || $(hg root) != $HOME ]]; then
        hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[green]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[blue]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
    fi
}

# PROMPT='
# %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
# $(virtualenv_info)$(prompt_char) '

PROMPT='
%{$(get_prompt_user_color)%}%n%{$reset_color%} at %{$(get_prompt_host_color)%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT='$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
