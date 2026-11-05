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
| Compositor (Hyprland)                                                 | basic         | [extra]; modular Lua config (dotfiles/hypr); scale 1.6 — 1.5 snaps, integer-logical scales apply; touch OOTB; colors → matugen    |
| XDG portals (hyprland + gtk)                                          | basic         | [extra]; installed with the compositor; screencast and file-dialog paths not yet exercised (no GUI apps)                          |
| Polkit agent (hyprpolkitagent)                                        | basic         | [extra]; running in the graphical session via Hyprland autostart (full binary path); validated                                    |
| Console font (Terminus ter-128n)                                      | basic         | [extra]; FONT=ter-128n in /etc/vconsole.conf (install.sh, idempotent); every VT; validated live in VT2                            |
| AUR helper (paru)                                                     | basic         | paru-bin 2.2.0 bootstrapped by install.sh (runuser delegation, idempotent); validated with a live AUR query                       |
| Web browser (Brave)                                                   | basic         | brave-bin 1.98.63 (AUR, upstream-maintained) via install.sh aur_packages; native Wayland (xwayland: 0) via brave-flags.conf; profile stays in ~ (personal data) |
| App launcher (fuzzel)                                                 | basic         | fuzzel 1.15.0 [extra]; opens on SUPER+SPACE (layer-shell, namespace launcher); font=Adwaita Sans; colors → matugen; icons → Appearance |
| Status bar (waybar)                                                   | basic         | waybar 0.15.0 [extra]; modules: hyprland/workspaces, clock, network, pulseaudio, battery, tray; colors → packaged default style (@imported, user css only overrides type: Adwaita Sans 15px); matugen will own the css; starts via hyprland.start |
| Text editor (Neovim)                                                  | basic         | nvim 0.12.6 [extra]; minimal init.lua (number, termguicolors) — plugins/keybinds/LSP → deep session; git core.editor: nvim; colors → default colorscheme until matugen |
| Color system (matugen)                                                | not installed | [extra]; needs a wallpaper as scheme source; retrofits apps via templates                                                         |
| Wallpaper (awww)                                                      | not installed | AUR awww-git → needs paru; switch wired to matugen regeneration                                                                   |
| Screenshots (grim + slurp)                                            | not installed | needs compositor; also documents validations                                                                                      |
| Clipboard (wl-clipboard + cliphist)                                   | not installed | needs compositor                                                                                                                  |
| Notifications (mako or dunst)                                         | not installed | needs compositor; daemon choice open                                                                                              |
| Screen lock and idle (hyprlock+hypridle or swaylock+swayidle)         | not installed | needs compositor; stack choice open                                                                                               |
| Shell (fish)                                                          | not installed | login-shell change captured in install.sh                                                                                         |
| File manager (superfile)                                              | not installed | [extra]; needs a Nerd Font (ghostty embeds one); includes xdg-user-dirs                                                           |
| Wi-Fi management (wlctl)                                              | not installed | AUR wlctl-bin → needs paru                                                                                                        |
| Bluetooth management (bluetuith)                                      | not installed | AUR → needs paru; pairing tests need hardware                                                                                     |
| Audio (PipeWire validation + mixer + keys)                            | not installed | stack pre-installed; reduces to validation, mixer choice, and media keys via compositor keybinds                                  |
| Peripherals and removable media (udisks2)                             | not installed | USB mounting without GUI; microSD reader and webcam tests                                                                         |
| Login manager (greetd + tuigreet)                                     | not installed | compositor validated — ready to land; greeter inherits the console font (separate component)                                      |
| Power management                                                      | not installed | suspend coordinated with the lock/idle stack                                                                                      |
| Appearance (GTK/Qt, cursors, icons, fonts)                            | not installed | partial: system Nerd Font landed (GeistMono Nerd — feeds icon consumers at styling); remaining matugen templates (e.g., gtk.css)  |
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
| Audio mixer: pulsemixer (TUI) vs. pwvucontrol (GUI)                 | Audio                             |
| Login manager greeter: tuigreet (now in [extra], was AUR-only) vs. agreety vs. ly | Login manager                     |
| Disable NetworkManager-wait-online?                                 | Boot polish and system resilience |
| rEFInd menu timeout and HiDPI font                                  | Boot polish and system resilience |
| Add a linux-lts fallback kernel?                                    | Boot polish and system resilience |
