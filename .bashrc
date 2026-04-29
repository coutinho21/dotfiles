#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export BROWSER=firefox

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias l='ls -lah'
alias venv='source /home/coutinho/venv/bin/activate'
alias shigarra='/home/coutinho/go/bin/shigarra'

fastfetch
export PATH="$HOME/.local/bin:$PATH"
