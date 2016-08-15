#!/usr/bin/env bash

# Get sudo permission upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################### XCode Command Line Tools ###################
# from https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

  echo "Installing Xcode Command Line Tools"
  xcode-select --install
  
  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
      sleep 5
  done

  # Point the `xcode-select` to the appropriate directory in `Xcode.app`
  # https://github.com/alrra/dotfiles/issues/13
  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

fi

################### Homebrew ################### 

echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/services
brew tap caskroom/versions

brew upgrade --all

################### Shell/GNU Utilites ################### 

echo "Installing up-to-date core utilities"
brew install coreutils moreutils findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install ack
brew install pv rename
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install Bash 4.
brew install bash
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo "Installing an updated version of Bash"
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install completions
brew install bash-completion

# Install more recent versions of some macOS tools.
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/dupes/whois
brew install openssl


################### Git ################### 

echo "Installing the latest version of Git"
brew install git

echo "Installing Git utilities"
brew install git-lfs bfg hub # alias hub as git!
brew cask install github-desktop


################### Other Utilities ################### 

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 sfntly ots fonttools

# Image Tools
brew install imagemagick optipng

# Compression/Decompression
brew install p7zip brotli zopfli

# Forensics
brew install exiftool foremost

# Wifi
brew install wifi-password # "what's the wifi-password? Oh, let me sh that for you:"

################### Programming Languages ################### 

echo "Installing Programming Languages"

brew install python3

brew cask install java visualvm
brew install scala sbt
brew install leiningen

brew cask install racket

brew install haskell-platform haskell-stack

brew install elm

# Frameworks
#pip3 install django
#stack install hakyll

################### Databases ################### 

echo "Installing Databases"
brew install mysql 
brew install postgres
brew install mongo

################### Applications ###################

# Quicklook plugins
brew cask install suspicious-package quicklook-json quicklook-csv qlmarkdown qlstephen qlcolorcode 

# Text-Editors
brew install vim --override-system-vi
brew cask install sublime-text
brew cask install atom
brew cask install focuswriter

# Browsers
brew cask install google-chrome firefox
brew cask install caskroom/versions/firefoxdeveloperedition
brew cask install caskroom/versions/safari-technology-preview

# Communication
brew cask install skype slack

# Virtulaization
brew cask install virtualbox

# Media Playback
brew cask install vlc

# Others
brew cask install flux 
brew cask install spectacle

################### Finish ################### 

# Remove outdated versions from the cellar.
brew cleanup

echo "Complete."
