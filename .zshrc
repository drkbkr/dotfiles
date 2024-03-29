fpath=(/root/.config/zsh $fpath)
autoload -Uz prompt; prompt

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

#-----------------------------
# Pyenv
#-----------------------------
if [ -z $POETRY_ACTIVE ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv init --path)"
    fi
fi

export PATH=${PATH}:/usr/bin/core_perl

alias ll='ls -al'
