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


#alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias ls="ls -lh --color=auto"
  [ -f /usr/share/bash-completion/bash-completion ] && source /usr/share/bash-completion/bash-completion;
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -hlG"
  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

alias grep="grep --color=auto"
alias gs="git status"
alias gt="git log --graph --decorate --oneline --all "
alias gto="git log --graph --decorate --oneline"
alias lg="lazygit"
alias json='python3 -mjson.tool'

export EDITOR=vim

# DEVICE SPECIFIC CONFIG
[ -f ~/.device_bashrc ] && source ~/.device_bashrc;

#FZF
# need to work out how to use layout=normal in vim
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
gc() { git branch | fzf --layout=reverse --height 40% | xargs git checkout; }
export FZF_DEFAULT_COMMAND='rg --files --hidden'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(fnm env --use-on-cd)"
