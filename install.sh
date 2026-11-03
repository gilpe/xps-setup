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
)

pacman -Syu --needed --noconfirm "${packages[@]}"

echo "install.sh: done."
