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
alias gwn="~/dev/scripts/gitwalk.sh next"
alias gwp="~/dev/scripts/gitwalk.sh prev"
alias jnb="$HOME/.jnb.sh"
alias snlp="conda activate snlp"
alias vim="/usr/local/bin/lvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#if command -v pyenv 1>/dev/null 2>&1; then
 # eval "$(pyenv init -)"
#fi


export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PATH:/usr/local/opt/llvm@11/bin"
# export PATH="$PATH:~/dev/sourcekit-lsp/.build/debug"
# export PATH="$PATH:~/dev/sourcekit-lsp/.build"
export PATH="~/dev/sourcekit-lsp/.build/x86_64-apple-macosx/debug:$PATH"
# export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"
. "$HOME/.cargo/env"
export PATH="/Users/j/.local/bin:$PATH"
export PATH="/Users/j/dev/languages/Odin/:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/j/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/j/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/j/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/j/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
