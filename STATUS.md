# STATUS.md — Project progress

Lightweight log so any future session or model can pick up where the last
one stopped. Read at session start, update before ending. Requirements live
in SPECS.md; the configuration itself lives in the repo.

## Current focus

Module 1 (base system and hardware diagnostics) completed 2026-10-31 via
read-only inspection. Verified inventory, base-system baseline and
findings are recorded in HARDWARE.md. What comes next lives in Pending
tasks below.

## Modules

| Module | Status | Notes |
|---|---|---|
| Base system and hardware diagnostics | done | 2026-10-31; baseline and findings in HARDWARE.md |
| Hyprland and desktop environment | not started | HiDPI 3200x1800; touchscreen (occasional use) |
| Terminal and shell | not started | Bash on bare TTY; no terminal emulator yet |
| Text editor | not started | No editor installed yet |
| File manager | not started | |
| Notifications and screen locking | not started | |
| Audio, networking, connectivity, and peripherals | not started | PipeWire stack pre-installed; Wi-Fi is Broadcom (see HARDWARE.md) |
| Power management (battery, suspend/hibernate) | not started | Raised by module 1 findings |
| Productivity tools | not started | |
| Appearance and customization | not started | |

The module list is orientative and evolves with the project. Hardware
facts and findings live in HARDWARE.md; open questions live in the
decision backlog under Pending tasks.

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
- 2026-10-31 — Module 1 completed (read-only inspection, no system
  changes). HARDWARE.md created as the verified hardware inventory and
  base-system baseline; SPECS.md §2, AGENTS.md repo layout and README.md
  updated to reference it.
- 2026-10-31 — Hibernation deferred: recorded as an open question for
  the power-management module (zram-only swap currently makes it
  impossible).
- 2026-10-31 — Touchscreen (ELAN): used occasionally → basic touch
  support in Hyprland; gestures vs. disabling decided later.
- 2026-10-31 — Reproducibility fix: `git` and `opencode` (installed
  manually on 2026-10-30, missing from the script) captured in
  install.sh.
- 2026-10-31 — Pending work centralized in STATUS.md: "Pending tasks"
  now splits into next steps (actions) and a decision backlog (deferred
  per-module decisions, removed as resolved). HARDWARE.md is
  reference-only and carries no TODOs; rule recorded in AGENTS.md.

## Pending tasks

### Next steps (actions)

- Choose and start the next module (suggested: terminal/shell and text
  editor first, per SPECS.md §5 — the editor makes configuring the rest
  easier).
- Inspect rEFInd configuration under /boot and clean the stale NVRAM
  boot entry (both need sudo) when boot polish is tackled.
- Optionally confirm whether BIOS 1.13.0 is the final release for the
  9350.

### Decision backlog (deferred to modules; remove each row when resolved)

| Open question | Module |
|---|---|
| Enable hibernation? (needs disk swap + resume= + bootloader change) | Power management |
| Touchscreen level of support (gestures vs. disable) | Hyprland |
| power-profiles-daemon vs. TLP | Power management |
| Disable NetworkManager-wait-online? | Boot polish / networking |
| rEFInd menu timeout and HiDPI font | Boot polish |
| Add a linux-lts fallback kernel? | System resilience |
