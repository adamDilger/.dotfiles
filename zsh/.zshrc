# Git branch in prompt.
# parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
autoload -U colors && colors
PROMPT='%{$fg[blue]%}%n%{$fg[white]%}:%1~ %{$fg[green]%}(${vcs_info_msg_0_})%{$fg[white]%} %# '
# PROMPT='%n@%m %1~ %# '

#color        \[\033[32m\]
# export PS1="\[\033[94m\]\u\[\033[00m\]:\W\\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$ "

PATH="$PATH:$HOME/scripts/";

# bash history (unlimited)
# HISTSIZE=
# HISTFILESIZE=

#alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias ls="ls -lh --color=auto"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -hlG"
fi

# ctrl+x e functionality
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

alias grep="grep --color=auto"
alias gs="git status"
alias gt="git log --graph --decorate --oneline --all "
alias gto="git log --graph --decorate --oneline"
alias lg="lazygit"
alias json='python3 -mjson.tool'

export EDITOR=vim

# zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# DEVICE SPECIFIC CONFIG
[ -f ~/.device_zshrc ] && source ~/.device_zshrc;

#FZF
# need to work out how to use layout=normal in vim
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
gc() { git branch | fzf --layout=reverse --height 40% | xargs git checkout; }
export FZF_DEFAULT_COMMAND='rg --files --hidden'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fnm env --use-on-cd)"
