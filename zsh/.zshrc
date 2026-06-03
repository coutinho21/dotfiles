# Update dbus
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
export MOZ_DBUS_REMOTE=1

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt NO_BEEP
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tsyr/.zshrc'
zstyle ':completion:*' menu select # for searching in the comletion with tab

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# Setting up keybinds
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Alt-Left]="\e[1;3D"
key[Alt-Right]="\e[1;3C"
key[Alt-Backspace]="\e\x7f"
key[Ctrl-Backspace]="^H"

delete-whole-line() {
	zle beginning-of-line
	zle kill-line
}

zle -N delete-whole-line

[[ -n "${key[Home]}"		]] && bindkey -- "${key[Home]}"			beginning-of-line
[[ -n "${key[End]}"		]] && bindkey -- "${key[End]}"			end-of-line
[[ -n "${key[Insert]}"		]] && bindkey -- "${key[Insert]}"		overwrite-mode
[[ -n "${key[Backspace]}" 	]] && bindkey -- "${key[Backspace]}"		backward-delete-char
[[ -n "${key[Delete]}"		]] && bindkey -- "${key[Delete]}"		delete-char
[[ -n "${key[Up]}"		]] && bindkey -- "${key[Up]}"			up-line-or-history
[[ -n "${key[Down]}"		]] && bindkey -- "${key[Down]}"			down-line-or-history
[[ -n "${key[Left]}"		]] && bindkey -- "${key[Left]}"			backward-char
[[ -n "${key[Right]}"		]] && bindkey -- "${key[Right]}"		forward-char
[[ -n "${key[PageUp]}"		]] && bindkey -- "${key[PageUp]}"		beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"	]] && bindkey -- "${key[PageDown]}"		end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"	]] && bindkey -- "${key[Shift-Tab]}"		reverse-menu-complete
[[ -n "${key[Control-Left]}"	]] && bindkey -- "${key[Control-Left]}"		backward-word
[[ -n "${key[Control-Right]}"	]] && bindkey -- "${key[Control-Right]}"	forward-word
[[ -n "${key[Alt-Left]}"	]] && bindkey -- "${key[Alt-Left]}"		beginning-of-line
[[ -n "${key[Alt-Right]}"	]] && bindkey -- "${key[Alt-Right]}"		end-of-line
[[ -n "${key[Alt-Backspace]}"	]] && bindkey -- "${key[Alt-Backspace]}"	delete-whole-line
[[ -n "${key[Ctrl-Backspace]}"	]] && bindkey -- "${key[Ctrl-Backspace]}"	backward-kill-word

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then 
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz line-init zle_application_mode_start
	add-zle-hook-widget -Uz line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# last visited dirs
autoload -Uz add-zsh-hook 

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi
chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt EXTENDED_GLOB

# rehashing 
# zstyle ':completion:*' rehash true # perfomance cost too high
zshcache_time="$(date +%s%N)"

rehash_precmd() {
	if [[ -a /var/cache/zsh/pacman ]]; then
		local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		if (( zshcache_time > paccache_time )); then
			rehash
			zshcache_time="$paccache_time"
		fi
	fi
}

add-zsh-hook -Uz precmd rehash_precmd
#
# custom add_paths function 
add_paths() {
	for d in "$@"; do
		[[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$PATH:$d"
	done
}

add_paths ~/bin ~/scripts /usr/lib/rstudio ~/go/bin

# exporting custom environment variables 
if [[ -s "$HOME/.env" ]]; then
	set -a		
	source ~/.env
	set +a 

fi

# ls output
# export LS_COLORS='di=1;0;1;41:ln=35:so=30;47:pi=0;42:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# zsh highlighting 
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=blue"
ZSH_HIGHLIGHT_STYLES[alias]="fg=116"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"
ZSH_HIGHLIGHT_STYLES[path]="fg=117"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=217"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=168,underline"
ZSH_HIGHLIGHT_STYLES[command]="fg=116"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=214"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=214"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=214"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=116"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=182"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=182"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


PROMPT='[%n@%m %~]$ '

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

alias l='ls --group-directories-first --color=auto -lah'
alias venv='source /home/coutinho/venv/bin/activate'
alias shigarra='/home/coutinho/go/bin/shigarra'
alias nervctf='/home/coutinho/tools/NervCTF/nervctf-linux-x86_64-static'

fastfetch
export PATH="$HOME/.local/bin:$PATH"

