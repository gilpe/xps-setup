#!/usr/bin/env bash
# install.sh — system provisioning for this workstation.
#
# Everything that is NOT application configuration belongs here: package
# installation (official repos and AUR), AUR helper setup, enabling
# services, required system file changes (e.g., /etc). Application
# configuration lives in dotfiles/ (see README.md § Repo layout).
#
# User-level and deliberately not scripted: git identity and
# `gh auth login` (personal data stays out of the repo;
# README.md § Working rules).
#
# Run as root: sudo ./install.sh

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "error: run as root: sudo ./install.sh" >&2
    exit 1
fi

# Packages from the official repositories.
packages=(
    github-cli   # GitHub CLI: git auth over HTTPS (gh auth login)
    git          # Version control (previously installed by hand)
    opencode     # AI coding agent driving this project (same)
    stow         # Dotfiles deployment: symlinks packages into $HOME (README § Repo layout)
    ghostty      # Terminal emulator — Wayland-native GTK4 (README § Component choices)
    lazygit      # Git TUI — review, stage, commit (README § Component choices)
    hyprland     # Compositor — Wayland (README § Component choices)
    hyprpolkitagent # Polkit authentication agent for the graphical session
    xdg-desktop-portal-hyprland # XDG portal backend: screencast via PipeWire
    xdg-desktop-portal-gtk # XDG portal backend: file dialogs for GTK apps
    brightnessctl # Brightness keys — used by the stock Hyprland binds
    terminus-font # HiDPI console font — ter-128n (README § Component choices)
)

pacman -Syu --needed --noconfirm "${packages[@]}"

# HiDPI console font: default8x16 is unreadable at ~276 PPI (HARDWARE.md).
# Applies immediately and at boot; affects every VT, not just a greeter.
if grep -q '^FONT=' /etc/vconsole.conf; then
    sed -i 's/^FONT=.*/FONT=ter-128n/' /etc/vconsole.conf
else
    echo 'FONT=ter-128n' >> /etc/vconsole.conf
fi
systemctl restart systemd-vconsole-setup.service

echo "install.sh: done."
