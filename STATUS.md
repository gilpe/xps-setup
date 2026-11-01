# STATUS.md — Project progress

Lightweight log so any future session or model can pick up where the last
one stopped. Read at session start, update before ending. Requirements live
in SPECS.md; the configuration itself lives in the repo.

## Current focus

Roadmap defined 2026-11-01: phase-based module order, Hyprland decomposed
into components, tool choices made, and the matugen color architecture
adopted (SPECS.md §4 revised). Next module to start: Terminal emulator
(ghostty).

## Modules

Ordered roadmap (defined 2026-11-01). Phase headings show the intended
sequence; within a phase the order is by priority and may be adjusted,
except where notes state a dependency.

### Phase 1 — Minimal functional desktop

| Module | Status | Notes |
|---|---|---|
| Base system and hardware diagnostics | done | 2026-10-31; baseline and findings in HARDWARE.md |
| Terminal emulator (ghostty) | next | [extra] 1.4; basic config first (Nerd Font, HiDPI size, keybinds — font also required by superfile); colors added by the color system module; runtime validation at Hyprland start (no GUI exists before it) |
| Hyprland core | not started | deps: terminal; compositor, HiDPI fractional scaling, inputs (basic touch), keybinds; launched from TTY; first app opened is ghostty |
| Color system (matugen) | not started | deps: Hyprland running; config + templates + initial wallpaper as scheme source; retrofits ghostty; single color source for every later module |
| Status bar (waybar) | not started | deps: Hyprland, color system; clock/battery/network/volume modules; CSS via matugen |
| App launcher (fuzzel) | not started | deps: Hyprland, color system; colors via matugen |
| AUR helper (paru) | not started | no deps; manual bootstrap once, captured in install.sh (non-root section) |
| Wallpaper (awww-git, ex-swww) | not started | deps: paru; AUR git build (swww renamed awww upstream); displays the current wallpaper; wallpaper switch wired to matugen regeneration |

### Phase 2 — Daily driver

| Module | Status | Notes |
|---|---|---|
| Web browser (Brave) | not started | deps: paru (AUR brave-bin, officially maintained by Brave); native Wayland; HiDPI |
| Text editor (Neovim) | not started | colors via matugen template |
| Shell (fish) | not started | login-shell change captured for reproducibility |
| File manager (superfile) | not started | [extra] 1.6; deps: Nerd Font; includes xdg-user-dirs; previews validated with ghostty |
| Wi-Fi management (wlctl) | not started | deps: paru (AUR wlctl-bin); drives NetworkManager over D-Bus — backend and Broadcom setup unchanged; nmtui stays installed as fallback |
| Bluetooth management (bluetuith) | not started | deps: paru (AUR, actively maintained); pairing tests |
| Screenshots (grim + slurp) | not started | deps: Hyprland; also used to document module validations |
| Clipboard (wl-clipboard + cliphist) | not started | deps: Hyprland |
| Notifications (mako or dunst) | not started | deps: Hyprland; daemon choice in-module; colors via matugen |
| Screen lock and idle (hyprlock+hypridle or swaylock+swayidle) | not started | deps: Hyprland; stack choice in-module; colors via matugen |

### Phase 3 — Integration and comfort

| Module | Status | Notes |
|---|---|---|
| XDG portals | not started | deps: Hyprland; xdg-desktop-portal-hyprland + gtk; screenshare and file dialogs |
| Polkit agent (hyprpolkitagent) | not started | deps: Hyprland; GUI authentication prompts |
| Audio (PipeWire validation + mixer + keys) | not started | stack pre-installed; mixer choice in-module; volume/brightness/media keys |
| Peripherals and removable media | not started | udisks2 USB mounting; microSD reader and webcam tests |
| Login manager (greetd + tuigreet) | not started | deps: Hyprland validated; recommended over ly (2026-11-01), confirm at module start; HiDPI greeter font is a vconsole system change → install.sh |

### Phase 4 — Stability and polish

| Module | Status | Notes |
|---|---|---|
| Power management (battery, suspend/hibernate) | not started | PPD vs TLP and hibernation are backlog rows; suspend coordinated with the lock/idle stack |
| Appearance (GTK/Qt, cursors, icons, fonts) | not started | consolidation; remaining matugen templates (e.g. gtk.css); cursors, icons, fonts |
| Boot polish and system resilience | not started | independent, low priority; rEFInd timeout + HiDPI font, stale NVRAM entry, wait-online, linux-lts fallback |
| Productivity tools | deferred | no concrete needs identified (2026-11-01); re-scope when they arise |

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
- 2026-11-01 — Roadmap redefined by dependency and usefulness in four
  phases. Hyprland decomposed into components (core, bar, launcher,
  wallpaper, screenshots, clipboard, portals, polkit, login manager);
  "Audio, networking, connectivity, and peripherals" split into audio,
  Wi-Fi, Bluetooth, and peripherals modules. Editor and shell moved
  after the browser (user priority: usefulness first; dependencies only
  force terminal → Hyprland core → GUI apps, and paru → AUR packages).
- 2026-11-01 — Color architecture: matugen (Material You, generated
  from the wallpaper) replaces Atom One Dark/Light as the visual
  identity; SPECS.md §4 and the AGENTS.md visual-consistency rule
  revised. All color-consuming configs are matugen templates; no
  literal colors.
- 2026-11-01 — Phase 1 ordered GUI-first: the graphical session
  (Hyprland core) exists before any theming; the color system follows
  it, retrofits ghostty with its template, and themes every downstream
  component once.
- 2026-11-01 — Component choices (user): ghostty, fish, Neovim,
  superfile, Brave (AUR brave-bin), fuzzel, waybar, paru, bluetuith
  (AUR), awww-git (ex-swww, AUR), wlctl (Wi-Fi, see below). Deferred:
  productivity tools, usability extras (emoji font, compression tools,
  gammastep), dev tools, backups.
- 2026-11-01 — Wi-Fi management: wlctl (AUR wlctl-bin, impala fork
  driving NetworkManager over D-Bus) chosen over nmtui — the working
  Broadcom/brcmfmac + wpa_supplicant setup stays untouched. nmtui
  remains installed as fallback. Being AUR-only, the module sits after
  paru.
- 2026-11-01 — Login manager recommendation: greetd + greetd-tuigreet
  over ly (ly flagged out-of-date 2026-08-24; greetd actively
  maintained, greeter/session separation, easy TTY fallback). To
  confirm at module start.
- 2026-11-01 — Availability verified: ghostty 1.4.0, superfile 1.6.0,
  matugen 4.2.0 and greetd-tuigreet 0.11.1 in [extra]; brave-bin,
  bluetuith, awww-git, wlctl-bin and paru in AUR; swww renamed awww
  upstream (no stable Arch package); Zen Browser still on beta channel
  → Brave chosen.

## Pending tasks

### Next steps (actions)

- Start the Terminal emulator (ghostty) module (first of the roadmap).
- Inspect rEFInd configuration under /boot and clean the stale NVRAM
  boot entry (both need sudo) when boot polish is tackled.
- Optionally confirm whether BIOS 1.13.0 is the final release for the
  9350.

### Decision backlog (deferred to modules; remove each row when resolved)

| Open question | Module |
|---|---|
| Enable hibernation? (needs disk swap + resume= + bootloader change) | Power management |
| Touchscreen level of support (gestures vs. disable) | Hyprland core |
| power-profiles-daemon vs. TLP | Power management |
| Notifications daemon: mako vs dunst | Notifications |
| Lock/idle stack: hyprlock+hypridle vs swaylock+swayidle | Screen lock and idle |
| Audio mixer: pulsemixer (TUI) vs pwvucontrol (GUI) | Audio |
| Disable NetworkManager-wait-online? | Boot polish and system resilience |
| rEFInd menu timeout and HiDPI font | Boot polish and system resilience |
| Add a linux-lts fallback kernel? | Boot polish and system resilience |
