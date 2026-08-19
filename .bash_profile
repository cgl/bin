[[ $- == *i* ]] && echo ".bash_profile"
export LANG="en_GB.UTF-8"
export PS1="\u:\w $ "

# Keep interactive settings, including shared history, in one place.
# Bash login shells read .bash_profile; other interactive shells read .bashrc.
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  [[ $- == *i* ]] && echo "Done pyenv init"
fi

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local:$PATH"
PATH="$HOME/work/bin:$PATH"
PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"

PATH="~/.npm-global/bin:$PATH"
export PATH

export PYENV_ROOT="$HOME/.pyenv"

alias compare='git diff -- @{upstream}'

# Emacs setup
alias em='emacsclient -c -n' #
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
export GIT_EDITOR='emacsclient -c'
export GIT_SEQUENCE_EDITOR='emacsclient -c'
eval "$(/opt/homebrew/bin/brew shellenv)"
