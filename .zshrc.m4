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

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for
# completion. Caution: this setting can cause issues with multiline prompts
# (zsh 5.7.1 and newer seem to work) See
# https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(
  git 
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  fast-syntax-highlighting 
  zsh-autocomplete 
  autoupdate
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='lvim'
 else
   export EDITOR='lvim'
 fi

# Aliases
. __MACHINE_PATH__/alias.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Settings for autocomplete plugin
zstyle ':autocomplete:*' min-input 1  # characters (int)
zstyle ':autocomplete:*' min-delay 0.1

# Ranger env variables
export VISUAL='lvim'
export PAGER='less'

# test
