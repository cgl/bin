# ~/.bashrc
# Runs for interactive non-login shells (new tabs, ssh, etc.)

# Only run in interactive shells
[[ $- != *i* ]] && return

echo ".bashrc"

#######################################
# History (shared across all terminals)
#######################################
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
shopt -s histappend

# Append this tab's new commands, then import commands written by other tabs.
# Do not clear and reload the full history: concurrent tabs can lose commands.
_sync_bash_history() {
  builtin history -a
  builtin history -n
}

# Remove the legacy hook from shells that inherited the old exported value.
PROMPT_COMMAND="${PROMPT_COMMAND//history -a; history -c; history -r; /}"

# VS Code's prompt helper is a shell function, so an exported PROMPT_COMMAND can
# leave child shells with the function name but not its definition.
if [[ ${PROMPT_COMMAND:-} == *"__vsc_prompt_cmd_original"* ]] &&
   ! declare -F __vsc_prompt_cmd_original >/dev/null; then
  PROMPT_COMMAND="${PROMPT_COMMAND//__vsc_prompt_cmd_original; /}"
  PROMPT_COMMAND="${PROMPT_COMMAND//; __vsc_prompt_cmd_original/}"
  PROMPT_COMMAND="${PROMPT_COMMAND//__vsc_prompt_cmd_original/}"
fi

# Preserve existing prompt hooks and avoid adding this hook more than once if
# .bashrc is sourced repeatedly.
case ";${PROMPT_COMMAND:-};" in
  *";_sync_bash_history;"*) ;;
  *) PROMPT_COMMAND="_sync_bash_history${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac
# Prompt hooks are local shell state. Do not pass them to child shells.
export -n PROMPT_COMMAND

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
export PATH="/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"
export PATH="$HOME/.npm-global/bin:/opt/local/bin:/opt/local/lib/postgresql16/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
