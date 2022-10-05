#!/bin/bash

echo "Installing homebrew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Install homebrew packages..."
./brew.sh
echo "Install homebrew casks..."
./brew-cask.sh

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# git completion/status?

./symlink-setup.sh

# Key repeating in VS Code

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

