# STATUS.md — Live state

Read at session start; update before session end (rules: AGENTS.md).

Requirements and principles: README.md · hardware facts: HARDWARE.md.

## Component inventory

States: not installed · basic (installed, minimal usable configuration) · deep (fully configured).

Ordered by progress: completed components first (completion order), the current session scope right after them (marked ▶), the rest flat and unordered — dependencies are constraints, not a sequence.  

| Component                                                             | State         | Constraints/Notes                                                                                                                 |
| --------------------------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Dotfiles deployment (GNU stow)                                        | basic         | [extra]; deploy.sh stows all dotfiles/ packages into $HOME (README § Repo layout)                                                 |
| Terminal (ghostty)                                                    | basic         | [extra]; config deployed via stow (dotfiles/ghostty); font=GeistMono Nerd Font (system, ss11 ligatures; validated — README § Terminal font; font-family swap needed a session restart); colors → matugen |
| Git TUI (lazygit)                                                     | basic         | [extra]; defaults only — editor wired to Neovim (git core.editor); colors → matugen deferred to deep                              |
| Compositor (Hyprland)                                                 | basic         | [extra]; modular Lua config (dotfiles/hypr); scale 2 — user-tuned live (1.5 snaps on this panel, integer 2 applies as-is); touch OOTB; multimedia keys live (Fn row = media row: volume/mute via wpctl, playback via playerctl, brightness via brightnessctl — stock example block, validated single-fire incl. hold behavior: no repeat events on the Fn row); a previous double-registration traced to a hidden stock bind tail from the example port — lesson: grep conf/ for a keysym before adding binds; config reload: hyprctl reload re-evaluates the Lua (validated — no restart needed for conf/*.lua edits); colors → matugen |
| XDG portals (hyprland + gtk)                                          | basic         | [extra]; installed with the compositor; screencast and file-dialog paths not yet exercised                                        |
| Polkit agent (hyprpolkitagent)                                        | basic         | [extra]; running in the graphical session via Hyprland autostart (full binary path); validated                                    |
| Console font (Terminus ter-128n)                                      | basic         | [extra]; FONT=ter-128n in /etc/vconsole.conf (install.sh, idempotent); every VT; validated live in VT2                            |
| AUR helper (paru)                                                     | basic         | paru-bin 2.2.0 bootstrapped by install.sh (runuser delegation, idempotent); validated with a live AUR query                       |
| Web browser (Brave)                                                   | basic         | brave-bin 1.98.63 (AUR, upstream-maintained) via install.sh aur_packages; native Wayland (xwayland: 0) via brave-flags.conf; profile stays in ~ (personal data) |
| App launcher (fuzzel)                                                 | basic         | fuzzel 1.15.0 [extra]; opens on SUPER+SPACE (layer-shell, namespace launcher); font=Adwaita Sans; colors → matugen; icons → Appearance |
| Status bar (waybar)                                                   | basic         | waybar 0.15.0 [extra]; modules: hyprland/workspaces, clock, network, pulseaudio, battery, tray; colors → packaged default style (@imported, user css only overrides type: Adwaita Sans 15px); matugen will own the css; starts via hyprland.start |
| Text editor (Neovim)                                                  | basic         | nvim 0.12.6 [extra]; minimal init.lua (number, termguicolors) — plugins/keybinds/LSP → deep session; git core.editor: nvim; colors → default colorscheme until matugen |
| Terminal font (Geist Mono Nerd)                                       | basic         | otf-geist-mono-nerd 1.8.x [extra]; Provides ttf-font-nerd (feeds non-terminal icon consumers); ss11 opt-in ligatures in ghostty (validated); family resolved via fc-match — README § Component choices: Terminal font |
| File manager (superfile)                                              | basic         | [extra] 1.6.0; binary is spf — SUPER+E opens it in a ghostty window (TUI: needs terminal -e wrapper; bare TUI exec has no TTY and dies instantly); validated live (SUPER+E); defaults only — config → deep session if needed; icons served by the Terminal font; colors → matugen |
| Color system (matugen)                                                | not installed | [extra]; needs a wallpaper as scheme source; retrofits apps via templates                                                         |
| Wallpaper (awww)                                                      | not installed | AUR awww-git (lands via paru — available); switch wired to matugen regeneration                                                   |
| Screenshots (grim + slurp)                                            | not installed | ready to land — compositor basic; also documents validations                                                                      |
| Clipboard (wl-clipboard + cliphist)                                   | not installed | ready to land — compositor basic                                                                                                  |
| Notifications (mako or dunst)                                         | not installed | ready to land — compositor basic; daemon choice open (backlog)                                                                    |
| Screen lock and idle (hyprlock+hypridle or swaylock+swayidle)         | not installed | ready to land — compositor basic; stack choice open (backlog)                                                                     |
| Shell (fish)                                                          | not installed | changes the login shell — the chsh step will be captured in install.sh                                                            |
| Wi-Fi management (wlctl)                                              | basic         | AUR wlctl-bin 0.1.10-1 (via install.sh — script path validated); binary /usr/bin/wlctl (Provides was faithful); NetworkManager-native — backend untouched; validated: wlctl doctor walked the BCM4350 stack all-[ok] (rfkill, driver, association, IP, DNS, gateway, internet); no bind by design — occasional tool, runs from the terminal; defaults only — ~/.config/wlctl/config.toml (rebindable vim keys) → deep session if needed; icons via system GeistMono Nerd |
| Bluetooth management (bluetuith)                                      | not installed | AUR (lands via paru — available); pairing tests need hardware                                                                     |
| System monitor (TUI)                                                  | basic         | btop [extra] 1.4.7-1 landed via install.sh (all-in-one dashboard: CPU/mem/disk/net/temps — sensors on this system: coretemp, dell_smm, nvme, acpitz + battery widget); zero new deps; defaults only — ~40 theme files shipped (/usr/share/btop/themes) → matugen candidate at deep; validated live (4-pane dashboard, temps and battery visible, mouse sorting; a glance-level pass — deeper probe deferred to the next open session) |
| System info (TUI)                                                     | not installed | fastfetch-style system summary; shell-greeting integration decided at landing; tool choice open (backlog) — candidates: fastfetch, hyfetch, nitch; logo/colors → matugen |
| Disk usage analyzer (TUI)                                             | not installed | occasional space forensics on the 476.9 GiB NVMe; tool choice open (backlog) — candidates: ncdu, gdu, dust                        |
| Audio (PipeWire validation + mixer + keys)                            | basic         | stack pre-installed & validated (pipewire/wireplumber/pipewire-pulse/alsa 1.6.10 active, sink+source enumerated); mixer wiremix [extra] 0.11.0-1 landed (PipeWire-native TUI — README § Component choices) — validated live (tabs, volume via h/l, mute, default sink; Brave stream appeared in playback tab with living peak meter); media keys live & validated (F1-F6 wpctl/playerctl — playback drives Brave via MPRIS; F11/F12 brightnessctl; playerctl captured in install.sh); deferred refinements (later session): F9 search key → fuzzel, waybar volume/brightness handling |
| Peripherals and removable media (udisks2)                             | not installed | USB mounting without GUI; microSD reader and webcam tests                                                                         |
| Login manager (greetd + tuigreet)                                     | not installed | compositor validated — ready to land; greeter inherits the console font (separate component)                                      |
| Power management                                                      | not installed | suspend coordinated with the lock/idle stack                                                                                      |
| Appearance (GTK/Qt, cursors, icons, fonts)                            | not installed | remaining: matugen templates (gtk.css), cursors, icons — system fonts covered (Terminal font row)                                 |
| Boot polish and system resilience                                     | not installed | rEFInd menu timeout + HiDPI font; stale NVRAM entry (sudo needed); NetworkManager-wait-online; linux-lts fallback                 |
| Productivity tools                                                    | deferred      | no concrete needs identified; re-scope when they arise                                                                            |
| Extras (emoji font, compression tools, gammastep, dev tools, backups) | deferred      | no concrete needs identified; re-scope when they arise                                                                            |

## Deferred validations

Rows are added when a component lands but cannot be fully validated
yet; the session that lands the unblocking component closes the row.

None open.

## Decision backlog

Open choices and deferred questions; a row is removed when resolved
(tool choices graduate to README.md § Component choices).

| Open question                                                       | Component                         |
| ------------------------------------------------------------------- | --------------------------------- |
| Enable hibernation? (needs disk swap + resume= + bootloader change) | Power management                  |
| Touchscreen support level (gestures vs. disable)                    | Compositor                        |
| power-profiles-daemon vs. TLP                                       | Power management                  |
| Notifications daemon: mako vs. dunst                                | Notifications                     |
| Lock/idle stack: hyprlock+hypridle vs. swaylock+swayidle            | Screen lock and idle              |
| Login manager greeter: tuigreet (now in [extra], was AUR-only) vs. agreety vs. ly | Login manager                     |
| Disable NetworkManager-wait-online?                                 | Boot polish and system resilience |
| rEFInd menu timeout and HiDPI font                                  | Boot polish and system resilience |
| Add a linux-lts fallback kernel?                                    | Boot polish and system resilience |
| System info TUI: fastfetch vs alternatives (evaluate at landing)      | System info   |
| Disk usage analyzer: ncdu vs gdu vs dust (evaluate at landing)        | Disk usage analyzer |
