# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=~/.local/bin:$PATH

# Set up aliases
alias ls="ls -Gla"
alias l="git log --stat"
alias s="git status"
alias dt="git difftool"
alias co="git checkout"
alias gph="git push origin head"
alias ls="ls -Gla"
alias l="git log --stat"
alias s="git status"
alias dt="git difftool"
alias co="git checkout"
alias gph="git push origin head"
alias gs="git stash"
alias gsp="git stash pop"
alias vim="~/.local/bin/lvim"

# Set up ls colors
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
