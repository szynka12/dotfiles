# vim: set filetype=zsh:

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/__USER__/.oh-my-zsh"

# Theoretically I could exchange prompts, but nah
. __SRC_PATH__/prompt/__PROMPT__.sh

plugins=(
  git 
  zsh-syntax-highlighting 
  autoupdate
  # zsh-autocomplete 
  # zsh-autosuggestions 
)

source $ZSH/oh-my-zsh.sh

. __SRC_PATH__/zsh_config.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='lv'
else
  export EDITOR='lv'
fi

# Ranger env variables
export VISUAL='lv'
export PAGER='less'


# Aliases -------------------------------------
alias alg="$EDITOR $HOME/dotfiles/alias.sh"
alias alm="$EDITOR __MACHINE_PATH__/alias.sh"

# general aliases
. __SRC_PATH__/alias.sh

# Aliases specific to a machine 
. __MACHINE_PATH__/alias.sh

# Move the completion to a different folder 
() {
  emulate -L zsh
  local -r cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
  autoload -Uz _store_cache compinit
  zstyle ':completion:*' use-cache true
  zstyle ':completion:*' cache-path $cache_dir/.zcompcache
  [[ -f $cache_dir/.zcompcache/.make-cache-dir ]] || _store_cache .make-cache-dir
  compinit -C -d $cache_dir/.zcompdump
}



# Autocomplete
() {
  # all Tab widgets
  zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

  # all history widgets
  zstyle ':autocomplete:*history*:*' insert-unambiguous yes

  # ^S
  zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

  zstyle ':autocomplete:*' min-input 3
  zstyle ':autocomplete:*' delay 0.1  # seconds (float)
  zstyle ':autocomplete:*' ignored-input '..##'

  # Make Tab and ShiftTab cycle completions on the command line
  bindkey "^n" menu-complete
  bindkey "^p" reverse-menu-complete

  # Enter always runs 
  bindkey -M menuselect '^M' .accept-line

}

# Replace ls with eza
() {
  # EZA_CONFIG_DIR="$HOME/.config/eza"
  unset LS_COLORS
  alias ls="eza --icons"
  alias ll="eza -lh --icons"
}
