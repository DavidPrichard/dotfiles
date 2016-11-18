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

# Switch default shell to brew-installed bash
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
brew install wget --with-iri


################### Git ###################

echo "Installing the latest version of Git"
brew install git

echo "Installing Git utilities"
brew install git-lfs bfg cloc hub # alias hub as git!
brew cask install github-desktop

################### Languages and Package Mangers ###################

echo "Installing Programming Languages"

brew install ruby # yes, even though it was installed for Homebrew itself.

brew install python3
pip3 install virtualenv

brew install go
export PATH=$PATH:/usr/local/opt/go/libexec/bin # to enable go get

brew cask install racket

brew cask install java visualvm
brew install scala sbt wartremover
brew install leiningen # clojure

brew install haskell-platform haskell-stack

brew install elm
brew install npm

################### Web Frameworks ###################

sudo gem install jekyll
pip3     install django
pip3     install flask
raco pkg install pollen
stack    install hakyll

################### Other Utilities ###################

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 sfntly ots fonttools

# Image Tools
brew install imagemagick optipng
go get -u github.com/fogleman/primitive

# Compression/Decompression
brew install p7zip brotli zopfli

# Forensics
brew install exiftool foremost

# Networking
brew install nmap # port-scanner
brew install httpie # http requests, etc.
go get -u github.com/davidprichard/httpstat # latency
brew install wifi-password # "what's the wifi-password?"
npm install -g iponmap

# Misc
brew install dark-mode

################### Databases ###################

echo "Installing Databases"
brew install mariadb
brew install postgres

################### Applications ###################

# Quicklook plugins
brew cask install suspicious-package quicklook-json quicklook-csv qlmarkdown qlstephen qlcolorcode

# Text-Editors
brew install vim --override-system-vi
brew cask install sublime-text
brew cask install atom
brew cask install visual-studio-code
brew cask install focuswriter

# Browsers
brew cask install google-chrome firefox
brew cask install caskroom/versions/firefoxdeveloperedition
brew cask install caskroom/versions/safari-technology-preview

# Backup
brew cask install crashplan

# Communication
brew cask install skype slack

# VMs
brew cask install virtualbox

# Media Playback
brew cask install vlc

# SFTP Client
brew cask install cyberduck

# Others
brew cask install flux
brew cask install spectacle
brew cask install unity

################### App Store ###################
brew install mas

echo "Enter your Apple ID (email) to install App Store programs."
read apple_id
mas signin $apple_id

mas install 1175103038 # Primitive

################### Finish ###################

# Remove outdated versions from the cellar.
brew cleanup

echo "Complete."
