export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"


export EDITOR='nvim'

export KEYTIMEOUT=1

typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char
[[ -n "$key[PageUp]"    ]] && bindkey -- "$key[PageUp]"    history-beginning-search-backward
[[ -n "$key[PageDown]"  ]] && bindkey -- "$key[PageDown]"  history-beginning-search-forward

bindkey '^ ' autosuggest-accept
bindkey -M viins '^v' vi-cmd-mode
bindkey -v

setopt prompt_subst

RPROMPT='${VIMODE}'

# Modify keybinds based on mode
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Prompt Vi Mode
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/"%F{red}NORMAL"}/(main|viins)/"%F{yellow}INSERT"}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey '^ ' autosuggest-accept

# Colors
autoload -U colors && colors

PROMPT="%B% %F{58}┌%F{red}Ash%F{yellow}[%F{white}%~%F{yellow}]%f
%F{58}└╼%F{166}$%{$reset_color%}%f%b "
# Tab Completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
compinit -d ~/bin/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)
setopt no_prompt_cr

# Load aliases
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Auto cd
setopt auto_cd

# LS when cd
cd() { builtin cd "$1" && ls; }

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/bin/zsh/.zshistory

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
eval "$(zoxide init zsh)"


autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
