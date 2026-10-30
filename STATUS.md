# STATUS.md — Project progress

Lightweight log so any future session or model can pick up where the last
one stopped. Read at session start, update before ending. Requirements live
in SPECS.md; the configuration itself lives in the repo.

## Current focus

Project tooling complete and validated (git identity, fixed origin,
GitHub CLI auth, initial push). Next module: base system and hardware
diagnostics — start with the read-only inspection workflow (AGENTS.md).

## Modules

| Module | Status | Notes |
|---|---|---|
| Base system and hardware diagnostics | next | Chosen as first module |
| Hyprland and desktop environment | not started | |
| Terminal and shell | not started | |
| Text editor | not started | |
| File manager | not started | |
| Notifications and screen locking | not started | |
| Audio, networking, connectivity, and peripherals | not started | |
| Productivity tools | not started | |
| Appearance and customization | not started | |

The module list is orientative: it will be redefined from the base
system analysis — findings, questions, and recommendations (SPECS.md §5).

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
- 2026-10-30 — First module chosen: base system and hardware diagnostics
  (dependency root; informs all hardware-dependent choices).
- 2026-10-30 — AGENTS.md updated: permission-request rule, sudo
  sub-steps with user intervention point, pending-task verification on
  session start.

## Pending tasks

- Start the base system and hardware diagnostics module (workflow per
  AGENTS.md: read-only inspection first, proposal before any change).
