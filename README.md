# .dotfiles

## Setup

```sh
cd ~;
git clone git@github.com:adamDilger/.dotfiles.git;
cd .dotfiles;
stow *;
```

## macos key repeat

```sh
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
```
