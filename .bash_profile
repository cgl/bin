[[ $- == *i* ]] && echo ".bash_profile"
export LANG="en_GB.UTF-8"
export PS1="\u:\w $ "

# 1. Avoid overwriting: Append to history instead of overwriting the file
shopt -s histappend

# 2. Save and reload history after every command
# This shares history across all open tabs instantly
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# 3. Increase history size (optional but recommended)
export HISTSIZE=100000
export HISTFILESIZE=10000

# 4. Ignore duplicates and simple commands like 'ls' or 'bg'
export HISTCONTROL=ignoreboth

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  [[ $- == *i* ]] && echo "Done pyenv init"
fi

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"

PATH="$HOME/work/bin:$PATH"
PATH="/usr/local/opt/sqlite/bin:$PATH"
PATH="/usr/local/opt/node@8/bin:$PATH"
PATH="/usr/local/opt/python@3.8/bin:$PATH"
PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"

export PATH

alias compare='git diff -- @{upstream}'

# Emacs setup
alias em='emacsclient -c -n' #
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

export PATH="~/.npm-global/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
