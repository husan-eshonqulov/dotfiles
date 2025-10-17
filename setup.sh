#!/bin/bash

set -eu

# --- Helpers ---
log() {
  echo -e "\033[1;32m[+] $1\033[0m"
}

# --- Hyprland Components ---
setup_hyprland() {
  log "Installing Hyprland"
  pacman -S --noconfirm hyprland && stow hyprland
}

setup_hyprpaper() {
  log "Installing Hyprpaper"
  pacman -S --noconfirm hyprpaper && stow hyprpaper
}

setup_hyprlock() {
  log "Installing Hyprlock"
  pacman -S --noconfirm hyprlock && stow hyprlock
}

setup_hypridle() {
  log "Installing Hypridle"
  pacman -S --noconfirm hypridle && stow hypridle
}

# --- Utilities ---
setup_waybar() {
  log "Installing Waybar"
  pacman -S --noconfirm waybar && stow waybar
}

setup_wofi() {
  log "Installing Wofi"
  pacman -S --noconfirm wofi && stow wofi
}

setup_kitty() {
  log "Installing Kitty"
  pacman -S --noconfirm kitty && stow kitty
}

setup_swappy() {
  log "Installing Swappy and dependencies"
  pacman -S --noconfirm grim slurp wl-clipboard swappy && stow swappy
}

# --- Shell ---
setup_starship() {
  log "Installing Starship"
  pacman -S --noconfirm starship
  stow starship
  if ! grep -Fxq 'eval "$(starship init bash)"' ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >>~/.bashrc
  fi
}

# --- Desktop Environment ---
setup_de() {
  log "Installing base packages"
  pacman -S --noconfirm \
    noto-fonts otf-font-awesome ttf-cascadia-code-nerd \
    brightnessctl firefox stow

  log "Stowing common configs"
  stow backgrounds hyprmocha readline

  log "Setting up Hyprland environment"
  setup_hyprpaper
  setup_hyprlock
  setup_hypridle
  setup_waybar
  setup_starship
  setup_wofi
  setup_kitty
  setup_swappy
  setup_hyprland

  log "Setup complete 🎉"
}

setup_de
