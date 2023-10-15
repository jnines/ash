# export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"


export EDITOR='nvim'
export KEYTIMEOUT=1

typeset -g -A key

bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" history-beginning-search-forward
bindkey "^[[6~" history-beginning-search-backward


#bindkey -M viins '^v' vi-cmd-mode
bindkey -e
bindkey '^ ' autosuggest-accept

setopt prompt_subst

#RPROMPT='${VIMODE}'

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

#zle -N zle-line-init
#zle -N zle-keymap-select

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

eval $(keychain --eval --quiet ash gry nlaptop)
