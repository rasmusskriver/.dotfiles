# Oh My Zsh opsætning
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
	git
)

source $ZSH/oh-my-zsh.sh
alias vim='nvim'
export GIT_EDITOR="nvim"

# vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Noget til tmux
#

#Tester i forhold til nemmere åbne wiki
# alias wiki='cd ~/MyWiki && nvim .'
#Anden test af wiki
# alias wiki='cd ~/MyWiki && nvim $(find . -type f -o -type d | fzf)'
# lua
# export PATH="$HOME/luaspil/lua-5.4.7/src:$PATH"
# Go Go Go Go Golaaaang
# export PATH=$PATH:/usr/local/go/bin
# HuGo GOGOGOGO
# export PATH=$PATH:$HOME/go/bin

# TESTER BASH
# export PATH=$PATH:$HOME/Projekter/scripts


# Miljøvariabler
# export XDG_CONFIG_HOME=$HOME/.config
# export TERM="alacritty"
# export PATH="$PATH:$HOME/.local/bin:$HOME/.local/scripts"
# export PATH="$PATH:$HOME/.fzf/bin"
# setxkbmap dk -variant nodeadkeys

# Ruby path
# export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
# Undgå at gems bliver installeret som root
# export GEM_HOME="$HOME/gems"
# export PATH="$HOME/gems/bin:$PATH"


# Begynder og forstå linus i forhold til nvidia drivers
# CUDA 12.6 setup
# export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
# export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# PopOS my man !!

# LSP
# export PATH=~/lua-language-server/bin:$PATH

# Keybindings
# bindkey -s ^f "tmux-sessionizer\n"
# bindkey -s ^b "tmux-batman\n"

# alias gaming="GamingSetupScript"
# alias gaming="~/.local/scripts/GamingSetupScript"
# Aliases
# alias python="python3"
# alias john="/home/rasmus/TryHackMe/john/run/john"
# alias zip2john="/home/rasmus/TryHackMe/john/run/zip2john"
# alias gpg2john="/home/rasmus/TryHackMe/john/run/gpg2john"
# alias bat="batcat"
# alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing

# Funktioner
# fzfp() {
#   fzf --preview "batcat --style=numbers --color=always {} || cat {}"
# }
# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
#
#
# Hvis der problemer med node og nvim slet nedenstående linjer og instaler node igen.
# https://nodejs.org/en/download
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
