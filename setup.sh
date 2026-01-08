#!/bin/bash
BKPATH=${BKPATH:-"$(realpath ~/jeff-old)"}
HOMEDIR="$(realpath ~)"
sudo pacman -S --noconfirm git rsync
cd ~
ssh-keygen
ssh-copy-id jeff@10.0.0.17
rsync -avz jeff@10.0.0.17:/volume1/jeff-old $HOMEDIR
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland
./setup install
cd ..

sudo pacman -S --noconfirm zsh zoxide btrfs-assistant podman-compose obsidian neovim tmux fzf npm nextcloud-client

chsh -s /bin/zsh
copyPath () {
    rm -rf "~/$1"
    cp -r "$BKPATH/$1" "$(dirname $(realpath ~/$1))"
}

# Config Files
copyPath ".config/nvim/"
copyPath ".config/kitty/"

# Shell Config
copyPath ".oh-my-zsh/"
copyPath ".zshrc"

# Tmux Config
copyPath ".tmux.conf"
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file "$(realpath ~/.tmux.conf)"

# Other Files to copy
copyPath "Pictures"
copyPath "Nextcloud"

# Configure hypr
nvim ~/.config/hypr/hypridle.conf
nvim ~/.config/hypr/hyprland/general.conf
nvim ~/.config/hypr/hyprland/keybinds.conf

