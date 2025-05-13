# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.rbenv/bin:/opt/brew/bin:/opt/brew/sbin/:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/.cli-scripts/bin:$PATH:$HOME/Library/Python/2.7/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# export ZSH_PECO_HISTORY_DEDUP=1

ZSH_THEME="vesopolis"
plugins=(vi-mode rbenv bundler brew ruby colored-man-pages)

UNBUNDLED_COMMANDS=(cap)
DISABLE_AUTO_UPDATE=true
source $ZSH/oh-my-zsh.sh

# User configuration
export HOMEBREW_NO_ANALYTICS=1
export ZSH_THEME="vesopolis"
export TERM=xterm-256color

unsetopt correct_all
unsetopt auto_name_dirs
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias ack="rg"

# lucky enough not to deal with kubernetes nowadays...
# if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
# alias k=kubectl

alias dc="docker compose"
alias dcu="dc up"
alias dcub="dcu --build"

export PATH="$HOME/.poetry/bin:$PATH"
export GOPATH=~
export GO111MODULE=on

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY
SHELL_SESSIONS_DISABLE=1
setopt sharehistory
ctags=/opt/brew/bin/ctags

source <(fzf --zsh)
