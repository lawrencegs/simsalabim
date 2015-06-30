#!/bin/bash
echo "Simsalabim :: Magic Deployment Tool"
echo "* web machine 0.1 *"
echo "  - nginx "
echo "  - php FPM "
echo "  - percona mysql "
echo "  - memcached "
echo "  - dnsmasq "

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
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

# Install PHP & PHP CLI
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew install --without-apache --with-fpm --with-mysql php55
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile 
. ~/.bash_profile
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist

# Install NGINX
brew install nginx
sudo cp `brew --prefix nginx`/homebrew.mxcl.nginx.plist /Library/LaunchDaemons/
sudo sed -i -e 's/`whoami`/root/g' `brew --prefix nginx`/homebrew.mxcl.nginx.plist
sudo mkdir /var/log/nginx/

# Install Percona MySQL server
brew install percona-server
brew link percona-server
unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix percona-server)" --datadir=/usr/local/var/percona --tmpdir=/tmp
mkdir -p ~/Library/LaunchAgents
cp /usr/local/opt/percona-server/homebrew.mxcl.percona-server.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist

# Install Memcached
brew install memcached
sudo cp `brew --prefix memcached`/homebrew.mxcl.memcached.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist

# Install DNSMasq to replace /etc/hosts
brew install dnsmasq 
cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH


binaries=(
  node
  git
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

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

