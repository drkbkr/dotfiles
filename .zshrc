#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  0.1.16                                                 #
# Author:   Øyvind "Mr.Elendig" Heggstad <mrelendig@har-ikkje.net> #
#------------------------------------------------------------------#

#-----------------------------
# Source some stuff
#-----------------------------
#BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.zhistfile
HISTSIZE=100000
SAVEHIST=100000

hist() { fc -lim "*$@*" 1 }

alias history="history 1"
alias update="sudo reflector -p https -f 10 --sort rate --save /etc/pacman.d/mirrorlist && yay -Syyu"
alias emulator_ssh="ssh -p 9922 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null acadia@localhost"
alias qemu_ssh="ssh -p 10022 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null acadia@localhost"

#------------------------------
# Variables
#------------------------------
export BROWSER="google-chrome-stable"
export EDITOR="vim"
export GOPATH="${HOME}/src/go"
export PATH="${PATH}:${GOPATH}/bin:${HOME}/bin:${HOME}/.poetry/bin"
export FZF_DEFAULT_COMMAND="find * -not \( -path '*/\.*' -prune \) -not \( -path '*buildroot/*' -prune \) -type f -print -o -type l -print 2> /dev/null"

#-----------------------------
# Pyenv
#-----------------------------
if [ -z $POETRY_ACTIVE ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
fi

#-----------------------------
# For Liveshare
#-----------------------------
#if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
#fi

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Use emacs Keybindings
#------------------------------
bindkey -e

#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias la="ls --color -la"

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    } 
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      vcs_info
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
    }
    ;; 
esac

#------------------------------
# Prompt
#------------------------------
#autoload -U colors zsh/terminfo
#colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[cyan]}%}]%{$reset_color%}"


#setprompt

# Bind up/down arrow keys to navigate through your history
#bindkey '\e[A' directory-history-search-forward
#bindkey '\e[B' directory-history-search-backward

# Bind CTRL+k and CTRL+j to substring search
#bindkey '^j' history-substring-search-up
#bindkey '^k' history-substring-search-down

SPACESHIP_CHAR_SYMBOL=$
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_GIT_SYMBOL=""
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#[ -f /etc/profile.d/autojump.zsh ] && source /etc/profile.d/autojump.zsh
