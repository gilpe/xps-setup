#!/usr/bin/env bash
# deploy.sh — user-level dotfiles deployment (companion to install.sh).
#
# install.sh provisions the system as root; this script deploys the
# application configuration in dotfiles/ into $HOME as the current user,
# with GNU stow (README.md § Repo layout).
#
# Run as your user (NOT sudo): ./deploy.sh

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
    echo "error: run as your user, not root: ./deploy.sh" >&2
    exit 1
fi

cd "$(dirname "$0")/dotfiles"

# One stow package per directory in dotfiles/ (e.g. ghostty/).
shopt -s nullglob
packages=(*/)
if ((${#packages[@]} == 0)); then
    echo "deploy.sh: nothing to deploy."
    exit 0
fi

# --restow converges $HOME to the repo state on re-runs (added/removed
# files inside a package are picked up).
stow -t ~ --restow "${packages[@]%/}"

echo "deploy.sh: deployed ${#packages[@]} package(s)."
