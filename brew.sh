#!/usr/bin/env bash

# Install command-line tools using Homebrew.

brew update
brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils moreutils findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install pv rename
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


# Install Bash 4.
brew install bash bash-completion
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Git etc.
brew install git git-lfs bfg ack hub # alias hub as git
brew cask install github-desktop

# Browsers
brew cask install firefoxdeveloperedition

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/dupes/whois
brew install openssl
brew link --force openssl

# Font Tools
brew tap bramstein/webfonttools
brew install woff2 sfntly ots fonttools

# Image Tools
brew install imagemagick optipng

# Compression/Decompression
brew install p7zip brotli zopfli

# Forensics
brew install exiftool foremost

# Wifi/Network traffic analysis
brew install aircrack-ng
brew install nmap
brew install tcpflow tcpreplay tcptrace
brew cask install wireshark-chmodbpf
brew install wireshark --with-qt5
brew install wifi-password # "what's the wifi-password? Oh, let me sh that for you:"
brew install testssl

# Other
brew cask install spectacle


# Remove outdated versions from the cellar.
brew cleanup
