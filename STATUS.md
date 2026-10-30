# STATUS.md — Project progress

Lightweight log so any future session or model can pick up where the last
one stopped. Read at session start, update before ending. Requirements live
in SPECS.md; the configuration itself lives in the repo.

## Current focus

Project tooling in progress: git identity configured, origin URL fixed,
install.sh created. Pending (user side): run `sudo ./install.sh`,
`gh auth login` + `gh auth setup-git`, then commit and push. Next:
choose the first module based on dependencies (SPECS.md §5 — e.g., the
text editor may unblock Hyprland work).

## Modules

| Module | Status | Notes |
|---|---|---|
| Base system and hardware diagnostics | not started | |
| Hyprland and desktop environment | not started | |
| Terminal and shell | not started | |
| Text editor | not started | |
| File manager | not started | |
| Notifications and screen locking | not started | |
| Audio, networking, connectivity, and peripherals | not started | |
| Productivity tools | not started | |
| Appearance and customization | not started | |

Module list, order, and scope are provisional (SPECS.md §5).

## Decisions

- 2026-10-30 — Adopted AGENTS.md as the operating guide for agents,
  STATUS.md as the single progress log. Target layout: `install.sh` for
  system provisioning, `dotfiles/` for application configuration.
- 2026-10-30 — Git/GitHub tooling: global git identity configured
  (user.name `gilpe`, real email), origin fixed to
  https://github.com/gilpe/xps-setup.git (was a broken http://www URL),
  authentication via GitHub CLI over HTTPS. install.sh created with
  `github-cli` as first package. Identity and credentials are user-level
  and excluded from install.sh per SPECS.md §6.

## Pending tasks

- User: run `sudo ./install.sh` (installs github-cli).
- User: `gh auth login` + `gh auth setup-git`, then commit and push
  AGENTS.md, STATUS.md, install.sh.
- Choose and start the first module.
