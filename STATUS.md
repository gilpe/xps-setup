# STATUS.md — Live state

Read at session start; update before session end (rules: AGENTS.md).

Requirements and principles: README.md · hardware facts: HARDWARE.md.

## Component inventory

States: not installed · basic (installed, minimal usable configuration) · deep (fully configured).

Ordered by progress: completed components first (completion order), the current session scope right after them (marked ▶), the rest flat and unordered — dependencies are constraints, not a sequence.  

| Component                                                             | State         | Constraints/Notes                                                                                                                 |
| --------------------------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Dotfiles deployment (GNU stow)                                        | basic         | [extra]; deploys dotfiles/ into $HOME: stow -d dotfiles -t ~ <package>                                                            |
| Terminal (ghostty)                                                    | basic         | [extra]; config deployed via stow (dotfiles/ghostty); embedded Nerd Font also serves superfile                                    |
| Compositor (Hyprland)                                                 | not installed | launched from TTY; a usable session also needs a terminal; basic touch support; unblocks visual validation of every GUI component |
| Color system (matugen)                                                | not installed | [extra]; needs a wallpaper as scheme source; retrofits apps via templates                                                         |
| Status bar (waybar)                                                   | not installed | needs compositor                                                                                                                  |
| App launcher (fuzzel)                                                 | not installed | needs compositor                                                                                                                  |
| Wallpaper (awww)                                                      | not installed | AUR awww-git → needs paru; switch wired to matugen regeneration                                                                   |
| Screenshots (grim + slurp)                                            | not installed | needs compositor; also documents validations                                                                                      |
| Clipboard (wl-clipboard + cliphist)                                   | not installed | needs compositor                                                                                                                  |
| Notifications (mako or dunst)                                         | not installed | needs compositor; daemon choice open                                                                                              |
| Screen lock and idle (hyprlock+hypridle or swaylock+swayidle)         | not installed | needs compositor; stack choice open                                                                                               |
| XDG portals (hyprland + gtk)                                          | not installed | needs compositor; screenshare and file dialogs                                                                                    |
| Polkit agent (hyprpolkitagent)                                        | not installed | needs compositor                                                                                                                  |
| AUR helper (paru)                                                     | not installed | bootstrap once manually, captured in install.sh; unblocks all AUR components                                                      |
| Web browser (Brave)                                                   | not installed | AUR brave-bin → needs paru; native Wayland                                                                                        |
| Text editor (Neovim)                                                  | not installed | —                                                                                                                                 |
| Shell (fish)                                                          | not installed | login-shell change captured in install.sh                                                                                         |
| File manager (superfile)                                              | not installed | [extra]; needs a Nerd Font (ghostty embeds one); includes xdg-user-dirs                                                           |
| Wi-Fi management (wlctl)                                              | not installed | AUR wlctl-bin → needs paru                                                                                                        |
| Bluetooth management (bluetuith)                                      | not installed | AUR → needs paru; pairing tests need hardware                                                                                     |
| Audio (PipeWire validation + mixer + keys)                            | not installed | stack pre-installed; reduces to validation, mixer choice, and media keys via compositor keybinds                                  |
| Peripherals and removable media (udisks2)                             | not installed | USB mounting without GUI; microSD reader and webcam tests                                                                         |
| Login manager (greetd + tuigreet)                                     | not installed | install once the compositor is validated; HiDPI greeter font is a vconsole change → install.sh                                    |
| Power management                                                      | not installed | suspend coordinated with the lock/idle stack                                                                                      |
| Appearance (GTK/Qt, cursors, icons, fonts)                            | not installed | consolidation; remaining matugen templates (e.g., gtk.css)                                                                        |
| Boot polish and system resilience                                     | not installed | rEFInd menu timeout + HiDPI font; stale NVRAM entry (sudo needed); NetworkManager-wait-online; linux-lts fallback                 |
| Productivity tools                                                    | deferred      | no concrete needs identified; re-scope when they arise                                                                            |
| Extras (emoji font, compression tools, gammastep, dev tools, backups) | deferred      | no concrete needs identified; re-scope when they arise                                                                            |

## Deferred validations

Rows are added when a component lands but cannot be fully validated
yet; the session that lands the unblocking component closes the row.

| Deferred validation                                                 | Component                         | Closes when                       |
| ------------------------------------------------------------------- | --------------------------------- | --------------------------------- |
| ghostty visual check — rendering, font size on the 3200x1800 panel  | Terminal (ghostty)                | Compositor (Hyprland) lands       |

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
| Login manager: greetd + tuigreet (recommended) vs. ly               | Login manager                     |
| Disable NetworkManager-wait-online?                                 | Boot polish and system resilience |
| rEFInd menu timeout and HiDPI font                                  | Boot polish and system resilience |
| Add a linux-lts fallback kernel?                                    | Boot polish and system resilience |
