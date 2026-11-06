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
    base-devel   # makepkg prerequisite — builds AUR packages (paru bootstrap below, future AUR use)
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
    playerctl  # Playback keys (F4/F5/F6) — used by the stock Hyprland binds (MPRIS)
    fuzzel   # App launcher — Wayland-native (README § Component choices)
    waybar   # Status bar — Wayland-native, GTK (README § Component choices)
    neovim   # Text editor — README § Component choices
    superfile # File manager TUI — README § Component choices (binary is spf)
    terminus-font # HiDPI console font — ter-128n (README § Component choices)
    otf-geist-mono-nerd # Nerd Font: terminal + future non-terminal consumers (README § Component choices: Terminal font)
    wiremix # Audio mixer TUI — PipeWire-native, no PA compat layer (README § Component choices: Audio mixer)
    btop    # System monitor TUI — all-in-one dashboard (README § Component choices: System monitor)
    fastfetch # System info TUI — terminal snapshot (README § Component choices: System info)
    ncdu    # Disk usage analyzer TUI — with delete confirmation (README § Component choices)
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

# AUR helper bootstrap — paru-bin (prebuilt; README § Component choices).
# makepkg refuses root, so install.sh delegates the clone and build to the
# invoking user (runuser) and installs the resulting package as root.
# Idempotent: skipped when paru is already on PATH.
if ! command -v paru >/dev/null; then
    [[ -n "${SUDO_USER:-}" ]] || { echo "error: bootstrap needs SUDO_USER; run via sudo" >&2; exit 1; }
    work="$(mktemp -d)"
    chown "$SUDO_USER:" "$work"
    runuser -u "$SUDO_USER" -- git clone --depth 1 \
        'https://aur.archlinux.org/paru-bin.git' "$work/paru-bin"
    (cd "$work/paru-bin" && runuser -u "$SUDO_USER" -- makepkg -sf --noconfirm)
    pacman -U --noconfirm "$work"/paru-bin/paru-bin-*.pkg.tar.zst
    rm -rf "$work"
fi

# AUR packages — built and installed through paru as the invoking user
# (makepkg refuses root; paru's internal sudo handles the root install,
# covered by the sudo timestamp of this same tty). Idempotent via --needed.
aur_packages=(
    brave-bin # Web browser — Chromium engine, built-in shields (README § Component choices)
    wlctl-bin # Wi-Fi TUI — impala fork pointed at NetworkManager (README § Component choices)
)
if ((${#aur_packages[@]})); then
    [[ -n "${SUDO_USER:-}" ]] || { echo "error: AUR installs need SUDO_USER; run via sudo" >&2; exit 1; }
    command -v paru >/dev/null || { echo "error: paru not found — run the bootstrap above first" >&2; exit 1; }
    runuser -u "$SUDO_USER" -- paru -S --needed --noconfirm "${aur_packages[@]}"
fi

# Git: Neovim as the editor — lazygit and the git CLI pick it up from
# core.editor. User-level: writes to the personal ~/.gitconfig (identity
# and credentials stay out of the repo, README § Working rules).
if [[ -n "${SUDO_USER:-}" ]]; then
    runuser -u "$SUDO_USER" -- git config --global core.editor nvim
else
    echo "warning: no SUDO_USER — set git core.editor manually" >&2
fi

echo "install.sh: done."
