#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

echo "Enabling Stealth Mode."
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

echo "Disable saving documents to iCloud by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Disable Captive Portal (automatically connecting to, say, hotel wifi through a Safari window)"
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

echo "Enable Secure Keyboard Entry in Terminal.app"
defaults write com.apple.terminal SecureKeyboardEntry -bool true

### More Aggressive Automatic Update ###
echo "Applying more aggressive automatic update settings"

# Enable the automatic update check, and set frequency to daily
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

echo "Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
