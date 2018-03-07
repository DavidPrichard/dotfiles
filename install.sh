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

echo "Chaning usr/local permissions for Ruby etc."
sudo chown -R $(whoami):admin /usr/local

################### Shell/GNU Utilites ###################

echo "Installing up-to-date core utilities"
brew install coreutils moreutils findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install ack
brew install pv rename
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install newest version of bash & completions
echo "Installing up-to-date version of bash."
brew install bash
brew install bash-completion

# Switch default shell to brew-installed bash
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

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
brew install git-lfs bfg cloc hub # hub is aliased as git by .aliases
brew cask install github-desktop

################### Languages and Package Mangers ###################

echo "Installing Programming Languages and Package Managers"

brew install ruby # yes, despite being installed for Homebrew itself.
gem install bundler

brew install python3
pip3 install virtualenv

brew install go

brew cask install racket

brew cask install java visualvm jprofiler
brew install scala sbt wartremover ammonite-repl
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

# File Tools
brew install tree # prints out directory structure.

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 ots fonttools #sfntly if they update to a maintained fork

# Image Tools
brew install imagemagick optipng
go get -u github.com/fogleman/primitive

# QR Generation
brew install qrencode

# Pass Generation and Management
pip3 install diceware
brew install pass && echo "source /usr/local/etc/bash_completion.d/password-store" >> ~/.bashrc

# Compression/Decompression
brew install p7zip brotli zopfli

# Forensics & Data Recovery
brew install exiftool # Exif Inspection/Alteration
brew install autopsy  # Sleuth Kit GUI Version
brew install foremost # file recovery
brew install ddrescue # copy entire partition w/ damage
brew install testdisk # filesystem repair

# Networking
brew install ncat  # general-purpose networking
brew install nmap  # port-scanner
brew install ngrep # network packet search

brew install httpie # http requests, etc.
go get -u github.com/davidprichard/httpstat # website latency

#w3af # web vuln. scanner
brew install skipfish
brew install sqlmap

brew install wifi-password # "what's the wifi-password?"
npm install -g iponmap # shows location of an IP address

# Misc/Fun
brew install dark-mode
brew install figlet

################### Applications ###################

# iTerm
brew cask install iterm2

# Quicklook plugins
brew cask install suspicious-package quicklook-json quicklook-csv qlmarkdown qlstephen qlcolorcode

# Text-Editors
brew install vim --override-system-vi
brew cask install sublime-text
brew cask install atom
brew cask install visual-studio-code
brew cask install focuswriter
brew cask install emacs

# Browsers
brew cask install google-chrome firefox
brew cask install caskroom/versions/firefoxdeveloperedition
brew cask install caskroom/versions/safari-technology-preview

# Backup
brew cask install crashplan

# Key/Pswd Management
brew cask install lastpass

# Communication
brew cask install skype slack

# VMs
brew cask install virtualbox

# Media Playback
brew cask install vlc

# SFTP Client
brew cask install cyberduck

# Security
brew cask install owasp-zap # basic web vuln. scanning

# Music Creation
brew cask install sonic-pi

# Misc/Fun
brew cask install cool-retro-term

# Others
brew cask install flux
brew cask install spectacle

################### Atom Plugins ###################

apm language-scala
apm install hydrogen # evaluation
#apm install ensime # buggy

apm install language-rust
apm install linter-rust

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
