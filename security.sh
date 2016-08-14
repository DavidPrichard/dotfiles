#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

echo "Enabling Firewall"
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true

echo "Enabling Stealth Mode."
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

echo "Disabling saving documents to iCloud by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Disabling Captive Portal (automatically connecting to, say, hotel wifi through Safari)"
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

echo "Disabling Bonjour mDNS advertisements"
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES

echo "Enabling Secure Keyboard Entry in Terminal.app"
defaults write com.apple.terminal SecureKeyboardEntry -bool true

echo "Lock screen after it goes to screensaver"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

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

echo "Don’t send search queries to Apple from Safari or Spotlight"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
