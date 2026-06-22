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
#echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/davidprichard/.zprofile
#eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade


################### Shell/GNU Utilites ###################

echo "Installing up-to-date core utilities"
brew install coreutils moreutils findutils
brew install gnu-sed ack
brew install wget --with-iri
brew install pv rename
brew install grep
brew install openssh openssl
brew install screen
brew install whois

#################### ZSH #####################

# ZSH itself installed by default with MacOS

# Install zsh plugins
brew install zsh-completions zsh-autosuggestions zsh-syntax-highlighting

# Force rebuild zcompdump
rm -f ~/.zcompdump; compinit

# Use Starship for custom prompt
brew install starship

################### Git ###################

echo "Installing the latest version of Git"
brew install git

echo "Installing Git utilities"
brew install bfg cloc hub # hub is aliased as git by .aliases
brew cask install github-desktop

################### Languages and Package Mangers ###################

echo "Installing Programming Languages and Package Managers"

brew install python3 go rustup npm
pip3 install virtualenv

################### Ansible ###################

pip3 install ansible

################### Other Utilities ###################

# File Tools
brew install tree # prints out directory structure.

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 ots fonttools #sfntly if they update to a maintained fork

# Image Tools
brew install imagemagick optipng

# QR Generation
brew install qrencode

# Pass Generation and Management
pip3 install diceware
#brew install pass && echo "source /usr/local/etc/bash_completion.d/password-store" >> ~/.bashrc

# Compression/Decompression
#brew install p7zip brotli zopfli

# Forensics & Data Recovery
brew install exiftool # Exif Inspection/Alteration
#brew install autopsy  # Sleuth Kit GUI Version
#brew install foremost # file recovery
#brew install ddrescue # copy entire partition w/ damage
#brew install testdisk # filesystem repair

# Networking
brew install netcat # general-purpose networking
brew install nmap   # port-scanner
brew install ngrep  # network packet search

brew install httpie # http requests, etc.
go get -u github.com/davidprichard/httpstat # website latency

#w3af # web vuln. scanner
#brew install skipfish
#brew install sqlmap

brew install wifi-password # "what's the wifi-password?"
npm install -g iponmap     # shows location of an IP address

# Misc/Fun
brew install figlet cowsay

################### Applications ###################

# iTerm
brew install --cask iterm2

# Quicklook plugins
#brew cask install suspicious-package quicklook-json quicklook-csv qlmarkdown qlstephen qlcolorcode

# Text-Editors
#brew install vim --with-override-system-vi
#brew cask install sublime-text
brew install --cask visual-studio-code
brew install --cask emacs

# Browsers
brew install --cask google-chrome firefox

# Backup
brew install --cask backblaze

# Communication
brew install --cask discord

# Media Playback
brew install --cask vlc

# SFTP Client
brew install --cask cyberduck

# Security
brew install --cask owasp-zap # basic web vuln. scanning

# Others
brew install --cask flux
$brew install --cask rectangle
brew install yt-dlp ffmpeg

################### App Store ###################
brew install mas

echo "Enter your Apple ID (email) to install App Store programs."
read apple_id
mas signin $apple_id

mas install 1175103038 # Primitive
mas install 777874532  # Cinemagraph Pro
# Magnet

################### Finish ###################

# Remove outdated versions and unneeded dependencies
brew cleanup
brew autoremove

echo "Complete."
