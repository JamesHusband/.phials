#!/usr/bin/env bash

SHARED_HOME="$DOTS_DIR"/shared/home/

shared_backup_existing() {
	message "Backing up existing dotfiles to $BACKUP_LOCATION"
	backup_files "$HOME"/.config/bat "$BACKUP_LOCATION"/.config/
	backup_files "$HOME"/.config/btop "$BACKUP_LOCATION"/.config/
	backup_files "$HOME"/.config/fastfetch "$BACKUP_LOCATION"/.config/
	backup_files "$HOME"/.config/ohmyposh "$BACKUP_LOCATION"/.config/
	backup_files "$HOME"/.config/topgrade.toml "$BACKUP_LOCATION"/.config/
	backup_files "$HOME"/.mozilla "$BACKUP_LOCATION"/
	backup_files "$HOME"/.oh-my-bash "$BACKUP_LOCATION"/
	backup_files "$HOME"/.bashenv "$BACKUP_LOCATION"/
	backup_files "$HOME"/.bashrc "$BACKUP_LOCATION"/
	backup_files "$HOME"/.gitconfig "$BACKUP_LOCATION"
	backup_files "$HOME"/.gitconfig.functions "$BACKUP_LOCATION"
	backup_files "$HOME"/.gitignore_global "$BACKUP_LOCATION"
	backup_files "$HOME"/.zshenv "$BACKUP_LOCATION"/
	backup_files "$HOME"/.zshrc "$BACKUP_LOCATION"/
	backup_files "$HOME"/.p10k.zsh "$BACKUP_LOCATION"/
	backup_files "$HOME"/.aliases "$BACKUP_LOCATION"/
	backup_files "$HOME"/.functions "$BACKUP_LOCATION"/
}

correct_ssh_permissions() {
	message "Settings $HOME/.ssh permissions"
	chmod 700 "$HOME"/.ssh
	chmod 600 "$HOME"/.ssh/*
}

install_bat_themes() {
    # Try to use Windows version of bat if not found in WSL
    if command -v bat > /dev/null; then
        message "Installing bat theme"
        bat cache --build
    elif command -v cmd.exe > /dev/null && cmd.exe /C bat --version > /dev/null; then
        message "Installing bat theme using Windows bat command"
        cmd.exe /C bat cache --build
    else
        warning_message "bat not detected... installation instructions: https://github.com/sharkdp/bat#installation"
    fi
}

install_fish_plugins() {
	if [[ $(command -v fish) ]]; then
		message "Installing fisher..."
		fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

		message "Installing fish plugins"
		warning_message "DO NOT configure Tide when prompted"

		git restore "$SHARED_HOME"/.config/fish/fish_plugins

		fish -c "fisher update"
	else
		warning_message "Fish not detected... installation instructions: https://fishshell.com/"
	fi
}

# initialize_submodules() {
# 	message "Pulling submodules"

# 	git submodule update --init --recursive --remote
# 	git pull --recurse-submodules
# }

shared_copy_configuration() {
	message "Copying shared config files"

	# copy home folder dotfiles if you dont want to use symlinks
	# copy_files "$DOTS_DIR"/shared/home ~

	# # link files that replace contents of location
  link_locations "$SHARED_HOME".zshrc "$HOME"/.zshrc
	link_locations "$SHARED_HOME".zshenv "$HOME"/.zshenv
	link_locations "$SHARED_HOME".aliases "$HOME"/.aliases
	link_locations "$SHARED_HOME".functions "$HOME"/.functions
	link_locations "$SHARED_HOME".p10k.zsh "$HOME"/.p10k.zsh
	link_locations "$SHARED_HOME"/.config/bat "$HOME"/.config/bat
	link_locations "$SHARED_HOME"/.config/btop "$HOME"/.config/btop
	link_locations "$SHARED_HOME"/.config/fastfetch "$HOME"/.config/fastfetch
	link_locations "$SHARED_HOME"/.config/ohmyposh "$HOME"/.config/ohymyposh
	link_locations "$SHARED_HOME"/.config/topgrade.toml "$HOME"/.config/topgrade.toml

	# link_locations "$SHARED_HOME"/.oh-my-bash "$HOME"/.oh-my-bash
	link_locations "$SHARED_HOME"/.oh-my-bash-custom/themes/powerlevel10k "$HOME"/.oh-my-bash/custom/themes/powerlevel10k

	link_locations "$SHARED_HOME"/.bashenv "$HOME"/.bashenv
	link_locations "$SHARED_HOME"/.bashrc "$HOME"/.bashrc
	link_locations "$SHARED_HOME"/.gitconfig "$HOME"/.gitconfig
	link_locations "$SHARED_HOME"/.gitconfig.functions "$HOME"/.gitconfig.functions
	link_locations "$SHARED_HOME"/.gitignore_global "$HOME"/.gitignore_global
	
	copy_files "$SHARED_HOME"/.local/ "$HOME"/.local/
	copy_files "$SHARED_HOME"/.mozilla/ "$HOME"/.mozilla/
}

shared_install() {

	# Backup
	shared_backup_existing

	# # Fetch dependencies
	# initialize_submodules

	# # Copy config
	shared_copy_configuration
	correct_ssh_permissions

	# # Installations
	shared_theme_install
}

shared_theme_install() {
	install_bat_themes
	install_fish_plugins
}
