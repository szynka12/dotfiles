# Settings for autocomplete plugin
zstyle ':autocomplete:*' min-input 1 # characters (int)
zstyle ':autocomplete:*' min-delay 0.1

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"

# ctrl-space to accept
bindkey '^ ' autosuggest-accept
bindkey '^.' autosuggest-toggle
