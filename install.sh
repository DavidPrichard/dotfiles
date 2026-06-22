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

echo "Changing usr/local permissions for Ruby etc."
sudo chown -R $(whoami):admin /usr/local

################### Shell/GNU Utilites ###################

echo "Installing up-to-date core utilities"
brew install coreutils moreutils findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install ack
brew install pv rename
brew install grep
brew install openssh
brew install screen
brew install whois
brew install openssl
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install zsh plugins
echo "Installing zsh plugins."
brew install zsh-autosuggestions zsh-completions zsh-syntax-highlighting

################### Git ###################

echo "Installing the latest version of Git"
brew install git

echo "Installing Git utilities"
brew install bfg hub # hub is aliased as git by .aliases
brew cask install github-desktop

################### Languages and Package Mangers ###################

echo "Installing Programming Languages and Package Managers"

brew install python go npm

brew install ruby # yes, despite being installed for Homebrew itself.
gem install bundler

curl https://sh.rustup.rs -sSf | sh -s -- -y # install rustup

################### Ansible ###################

brew install rsync libyaml # ansible deps
pip3 install setuptools wheel dnspython # ansible deps
pip3 install ansible-core
pip3 install "ansible-lint[core,yamllint]"

################### Other Utilities ###################

# Backup Tools
pip3 install --upgrade b2

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 ots fonttools #sfntly if brew updates to maintained fork

# Image Tools
brew install imagemagick optipng
go get -u github.com/fogleman/primitive

# QR Generation
brew install qrencode

# Pass Generation and Management
pip3 install diceware

# Compression/Decompression
brew install p7zip brotli

# Forensics & Data Recovery
brew install exiftool # Exif Inspection/Alteration
brew install autopsy  # Sleuth Kit GUI Version
brew install foremost # file recovery
brew install ddrescue # copy entire partition w/ damage
brew install testdisk # filesystem repair

# Networking
brew install nmap   # port-scanner
brew install httpie # http requests, etc.

#w3af # web vuln. scanner
brew install skipfish
brew install sqlmap

brew install wifi-password # "what's the wifi-password?"
npm install -g iponmap     # shows location of an IP address

# Misc/Fun
brew install dark-mode
brew install figlet

################### Applications ###################

# iTerm
brew cask install iterm2

# Quicklook plugins

# most of these no longer work due to being unsigned binaries
#brew cask install suspicious-package quicklook-json quicklook-csv qlmarkdown qlstephen qlcolorcode

# Text-Editors
brew cask install visual-studio-code

# Browsers
brew cask install google-chrome firefox

# Backup
#brew cask install backblaze

# Communication
brew cask install discord

# VMs
brew cask install virtualbox

# Media Playback
brew cask install vlc

# Security
brew cask install owasp-zap # basic web vuln. scanning

# Others
brew cask install flux
brew cask install spectacle

################### App Store ###################
brew install mas

echo "Enter your Apple ID (email) to install App Store programs."
read apple_id
mas signin $apple_id

mas install 1175103038 # Primitive
mas install 777874532  # Cinemagraph Pro

################### Finish ###################

brew autoremove
brew cleanup

echo "Complete."
