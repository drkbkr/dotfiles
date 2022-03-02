fpath=(/root/.config/zsh/prompt $fpath)
echo fpath is ${fpath}
autoload -Uz prompt; prompt

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
