#!/usr/bin/env bash
# install.sh — system provisioning for this workstation.
#
# Everything that is NOT application configuration belongs here: package
# installation (official repos and AUR), AUR helper setup, enabling
# services, required system file changes (e.g., /etc). Application
# configuration lives in dotfiles/ (see AGENTS.md).
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
)

pacman -S --needed --noconfirm "${packages[@]}"

echo "install.sh: done."
