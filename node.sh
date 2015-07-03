#!/bin/bash
echo "Simsalabim :: Magic Deployment Tool"
echo "* node machine 0.1 *"
echo "  - nodeJS"
echo "  - nginx "

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew"
brew update 

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
  node
  git
  github
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup
brew tap caskroom/versions
brew install caskroom/cask/brew-cask

# Apps
apps=(
  google-chrome
  firefox
  sublime-text3
  virtualbox
  atom
  skype
  cyberduck
  telegram
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

