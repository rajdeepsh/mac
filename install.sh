#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

echo "Setting up your mac..."
curl -fsSL https://raw.githubusercontent.com/rajdeepsh/mac/main/brewfile.txt | brew bundle --file=-

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1

mkdir -p $HOME/Repos

chmod 700 $HOME/.ssh
chmod 644 $HOME/.ssh/rajdeepsh.pub
chmod 600 $HOME/.ssh/rajdeepsh $HOME/.ssh/config

git config --global user.name "Rajdeep Singh Hundal"
git config --global user.email "rajd33psh@gmail.com"
git config --global gpg.format ssh
git config --global user.signingkey $HOME/.ssh/rajdeepsh.pub
git config --global commit.gpgsign true

git -C $HOME clone git@github.com:rajdeepsh/mac.git

echo
gum style --foreground 10 "✔ Done! Restarting..."
sudo shutdown -r now
