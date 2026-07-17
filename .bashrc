# ~/.bashrc
# Runs for interactive non-login shells (new tabs, ssh, etc.)

# Only run in interactive shells
[[ $- != *i* ]] && return

echo ".bashrc"

#######################################
# History (shared across all terminals)
#######################################
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Sync history on every prompt
PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

#######################################
# Prompt
#######################################
export PS1="\u:\w $ "

#######################################
# Editor
#######################################
export EDITOR="ec -t"
export VISUAL="ec"

#######################################
# Aliases
#######################################
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias compare='git diff -- @{upstream}'

#######################################
# Safety & quality of life
#######################################
shopt -s checkwinsize
bind 'set completion-ignore-case on'

#######################################
# Local overrides (not committed)
#######################################
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# Always retain the macOS system command directories, even when this file is
# sourced from a shell whose PATH was previously overwritten.
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"
export PATH="$HOME/.npm-global/bin:/opt/local/bin:/opt/local/lib/postgresql16/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
