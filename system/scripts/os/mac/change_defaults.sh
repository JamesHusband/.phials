#!/usr/bin/env bash
#
# ░█▀▄░█▀▀░█▀▀░█▀█░█░█░█░░░▀█▀░█▀▀
# ░█░█░█▀▀░█▀▀░█▀█░█░█░█░░░░█░░▀▀█
# ░▀▀░░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀
#
change_defaults() {
	message "Changing macOS defaults..."

	# Close any open System Preferences panes, to prevent them from overriding
	# settings we’re about to change
	osascript -e 'tell application "System Preferences" to quit'

	##
	# U X  D E F A U L T S
	##

	# Dock
	message "Changing dock defaults"
  # Enable highlight hover effect for the grid view of a dock stack
  defaults write com.apple.dock mouse-over-hilite-stack -bool true
  # Minimize windows into their application’s icon
  defaults write com.apple.dock minimize-to-application -bool true
  # Auto Hide Dock
  defaults write com.apple.dock autohide -bool false
  # Don't Show Recent Applications
  defaults write com.apple.dock show-recents -bool false
  # Change Default Minimize Effect
  defaults write com.apple.dock "mineffect" -string "scale"

  # Screenshots
  message "Changing screen capture defaults"
  # Remove Shadows from Screenshots
  defaults write com.apple.screencapture disable-shadow -bool true
  #  Change save location
  mkdir -p ~/Pictures/screenshots/
  defaults write com.apple.screencapture location -string "$HOME/Pictures/screenshots/"
  # Change file format
  defaults write com.apple.screencapture type -string "png"

  # Menubar
  # Change Clock to 24hr format
  defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm\""

	# Mission Control
	message "Changing Mission Control Defaults"
	# Don't Automatically rearrage spaces
	defaults write com.apple.dock "mru-spaces" -bool "false"

	# Restart Dock
	killall Dock

# 	##
# 	# A P P S
# 	##

# 	# Finder
	message "Changing Finder defaults"
	# Show hidden files
	defaults write com.apple.Finder "AppleShowAllFiles" -bool "true"
	# Show file extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	# Keep folders on top when sorting by name
	defaults write com.apple.finder _FXSortFoldersFirst -bool true
	# When performing a search, search the current folder by default
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	# Disable finder animations
	defaults write com.apple.finder DisableAllAnimations -bool true
	# Disable warning when changing file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	# Hide desktop icons
	# defaults write com.apple.finder CreateDesktop false
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
	defaults write com.apple.finder ShowStatusBar -bool true
	# Show path in title bar
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
	# Use list view in all Finder windows by default
	# NOTE: Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
	# Show the ~/Library folder
	chflags nohidden ~/Library
	# Show the /Volumes folder
	sudo chflags nohidden /Volumes
	# Show quit option
	defaults write com.apple.finder QuitMenuItem -bool true
	# Restart Finder
	killall Finder

	# Mail
	message "Changing Mail defaults"
	# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
	defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"
  # Display emails in threaded mode, sorted by date (newest at the top)
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedAscending" -string "yes"
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
	# Disable inline attachments (just show the icons)
	defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
	# Include address names in clipboard
	defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# 	# App Store
# 	message "Changing App Store defaults"
# 	# Enable the automatic update check
# 	defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# 	# Download newly available updates in background
# 	defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# 	# Install System data files & security updates
# 	defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
# 	# Turn on app auto-update
# 	defaults write com.apple.commerce AutoUpdate -bool true
# 	# Allow the App Store to reboot machine on macOS updates
# 	defaults write com.apple.commerce AutoUpdateRestartRequired -bool true


	message "Changing misc defaults"
	defaults write NSGlobalDomain AppleAccentColor -int 1
	defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
	defaults write com.apple.spaces spans-displays -bool false

	success_message "Defaults updated"
}
