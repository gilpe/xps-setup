# STATUS.md — Project progress

State log so any future session or model can pick up where the last one
stopped. Read at session start, update before ending — a session is not
closed until this file reflects the actual system state. Requirements
and chosen tools (premises) live in SPECS.md; hardware facts live in
HARDWARE.md. Base-system baseline verified 2026-10-31 (see HARDWARE.md).

## Component inventory

Flat and unordered — the user picks each session's scope (SPECS.md §5);
dependencies appear as constraints, not a sequence. State values: not
installed · basic (installed, minimal usable configuration) · deep
(fully configured: theming, keybinds, integration). Tool choices are
premises in SPECS.md §3; this table tracks state only.

| Component | State | Constraints / notes |
|---|---|---|
| Compositor (Hyprland) | not installed | launched from TTY; a usable session also needs a terminal; HiDPI fractional scaling; basic touch support; unblocks visual validation of every GUI component |
| Terminal (ghostty) | not installed | [extra] 1.4; embedded Nerd Font (also serves superfile); visual check deferred until the compositor runs |
| Color system (matugen) | not installed | [extra] 4.2; single color source (SPECS.md §4); needs a wallpaper image as scheme source; retrofits basic-depth apps via templates |
| Status bar (waybar) | not installed | needs compositor; clock/battery/network/volume modules; CSS via matugen |
| App launcher (fuzzel) | not installed | needs compositor; colors via matugen |
| Wallpaper (awww) | not installed | AUR awww-git → needs paru (swww renamed awww upstream); wallpaper switch wired to matugen regeneration |
| Screenshots (grim + slurp) | not installed | needs compositor; also used to document validations |
| Clipboard (wl-clipboard + cliphist) | not installed | needs compositor |
| Notifications (mako or dunst) | not installed | needs compositor; daemon choice open (backlog); colors via matugen |
| Screen lock and idle (hyprlock+hypridle or swaylock+swayidle) | not installed | needs compositor; stack choice open (backlog); colors via matugen |
| XDG portals (hyprland + gtk) | not installed | needs compositor; screenshare and file dialogs |
| Polkit agent (hyprpolkitagent) | not installed | needs compositor; GUI authentication prompts |
| AUR helper (paru) | not installed | bootstrap once manually, captured in install.sh (user-level section); unblocks all AUR components |
| Web browser (Brave) | not installed | AUR brave-bin → needs paru (officially maintained by Brave); native Wayland; HiDPI |
| Text editor (Neovim) | not installed | colors via matugen template |
| Shell (fish) | not installed | login-shell change captured in install.sh for reproducibility |
| File manager (superfile) | not installed | [extra] 1.6; needs a Nerd Font (ghostty embeds one); includes xdg-user-dirs; previews validated in the terminal |
| Wi-Fi management (wlctl) | not installed | AUR wlctl-bin → needs paru; drives NetworkManager over D-Bus (Broadcom setup untouched); nmtui stays installed as fallback |
| Bluetooth management (bluetuith) | not installed | AUR → needs paru; actively maintained; pairing tests need hardware |
| Audio (PipeWire validation + mixer + keys) | not installed | stack pre-installed; mixer choice open (backlog); volume/brightness/media keys via compositor keybinds |
| Peripherals and removable media (udisks2) | not installed | USB mounting without GUI; microSD reader and webcam tests |
| Login manager (greetd + tuigreet) | not installed | choice open (backlog); install once the compositor is validated; HiDPI greeter font is a vconsole change → install.sh |
| Power management | not installed | PPD vs TLP and hibernation open (backlog); suspend coordinated with the lock/idle stack |
| Appearance (GTK/Qt, cursors, icons, fonts) | not installed | consolidation; remaining matugen templates (e.g. gtk.css) |
| Boot polish and system resilience | not installed | rEFInd menu timeout + HiDPI font; stale NVRAM entry (sudo needed); NetworkManager-wait-online; linux-lts fallback; confirm BIOS 1.13.0 final for the 9350 |
| Productivity tools | deferred | no concrete needs identified (2026-11-01); re-scope when they arise |

## Deferred validations

Rows are added when a component lands but cannot be fully validated yet;
the session that lands the unblocking component closes the row.

No open rows.

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
  split into next steps (actions) and a decision backlog (deferred
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
  identity; SPECS.md §4 and the AGENTS.md visual-consistency rule revised.
  All color-consuming configs are matugen templates; no literal colors.
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
- 2026-11-02 — Planning model changed (supersedes the phased roadmap of
  2026-11-01): work is session-driven, with no fixed roadmap; the user
  defines each session's scope — new components, deepening existing
  ones, or as much as desired, possibly everything. SPECS.md §1/§5/§8
  and the AGENTS.md workflow rewritten accordingly. STATUS.md becomes a
  flat component inventory (state: not installed/basic/deep, plus
  constraints) with a deferred-validations registry; dependencies
  remain constraints, not an order. Tool choices unchanged.
- 2026-11-02 — Chosen tools recorded as premises in SPECS.md §3
  (component table); STATUS.md tracks state only. Open choices stay in
  the decision backlog and graduate to the premises table once decided
  via a decision entry.

## Decision backlog

Open choices and deferred questions. Each row is removed when resolved;
resolutions are recorded in Decisions and, for tool choices, graduate to
the SPECS.md premises table.

| Open question | Component |
|---|---|
| Enable hibernation? (needs disk swap + resume= + bootloader change) | Power management |
| Touchscreen level of support (gestures vs. disable) | Compositor |
| power-profiles-daemon vs. TLP | Power management |
| Notifications daemon: mako vs dunst | Notifications |
| Lock/idle stack: hyprlock+hypridle vs swaylock+swayidle | Screen lock and idle |
| Audio mixer: pulsemixer (TUI) vs pwvucontrol (GUI) | Audio |
| Login manager: greetd + tuigreet vs ly | Login manager |
| Disable NetworkManager-wait-online? | Boot polish and system resilience |
| rEFInd menu timeout and HiDPI font | Boot polish and system resilience |
| Add a linux-lts fallback kernel? | Boot polish and system resilience |
