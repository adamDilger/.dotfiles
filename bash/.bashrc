# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#color        \[\033[32m\]

export PS1="\[\033[94m\]\u\[\033[00m\]:\W\\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$ "

PATH="$PATH:~/scripts/";

#bash history (unlimited)
HISTSIZE=
HISTFILESIZE=

#tty fixes for vim
stty -ixon

#git autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias ls="ls -lh --color=auto"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -hlG"
fi

alias grep="grep --color=auto"
alias gs="git status"
alias gt="git log --graph --decorate --oneline --all "
alias gto="git log --graph --decorate --oneline"
alias lg="lazygit"
alias json='python -mjson.tool'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export EDITOR=vim

# DEVICE SPECIFIC CONFIG
[ -f ~/.device_bashrc ] && source ~/.device_bashrc;

#FZF
# need to work out how to use layout=normal in vim
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
gc() { git branch | fzf --layout=reverse --height 40% | xargs git checkout; }
export FZF_DEFAULT_COMMAND='rg --files --hidden'

findfile() { find . -name "*$1*"; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/opt/mssql-tools/bin"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
