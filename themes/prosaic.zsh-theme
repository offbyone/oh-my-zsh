#!/usr/bin/env zsh
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# -*- shell-script -*-
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function vcs_type() {
    hg_root=$(hg root 2>/dev/null)
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)

    [[ ${#hg_root} == 0 && ${#git_root} == 0 ]] && echo 'none' && return
    [[ ${#hg_root} == 0 ]] && echo 'git' && return
    [[ ${#git_root} == 0 ]] && echo 'hg' && return

    if [[ ${#hg_root} -gt ${#git_root} ]]; then
        echo 'hg'
    else
        echo 'git'
    fi
}

function prompt_char {
    git_prompt_char='±'
    hg_prompt_char='☿'
    default_prompt_char='○'

    case $(vcs_type) in
        git)
            echo $git_prompt_char
            ;;
        hg)
            echo $hg_prompt_char
            ;;
        *)
            echo $default_prompt_char
            ;;
    esac
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
    [ "$USER" = "root" ] && color=$fg[black]$bg[red]
    echo $color
}

function hg_prompt_info {
    if [[ $(vcs_type) == 'hg' ]]; then
        hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[green]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[blue]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
    fi
}

function git_prompt_if_applicable {
    [[ $(vcs_type) == 'git' ]] && git_prompt_info
}

PROMPT='
%{$(get_prompt_user_color)%}%n%{$reset_color%} at %{$(get_prompt_host_color)%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_if_applicable)
$(virtualenv_info)$(prompt_char) '

if [[ -z $INSIDE_EMACS ]]; then
    RPROMPT='$(battery_charge)'
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
