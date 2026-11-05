# XPS Setup — Project requirements

## 1. Objective

Progressively configure a personal Arch Linux workstation into a functional, lightweight, visually consistent, maintainable, and reasonably reproducible environment tailored to the user's needs.  

OpenCode AI models assist as technical helpers across one or many sessions, possibly different models; the user defines each session's scope and creates all commits.  

## 2. Reference hardware

Dell XPS 13 9350 (Intel Core i7-6500U, 16 GB RAM, QHD+ 3200x1800), vanilla Arch Linux. Verified hardware facts and base-system baseline: `HARDWARE.md`.  

## 3. Design principles

- **Simplicity** — explicit, understandable configs; no unnecessary abstractions, layers, or dependencies.
- **Performance** — lightweight components suited to this hardware; no marginal visual gains at the cost of responsiveness or stability.
- **Tools** — TUI first; GUI when it offers clear advantages; Wayland/Hyprland compatible by default.
- **Visual consistency** — one color source: the matugen scheme (§ Visual identity).
- **Maintainability** — configs easy to understand and modify manually.
- **Deliberate growth** — no premature complexity or automation without an established, concrete need.
- **Minimal home** — no default XDG user directories; `$HOME` stays clean and folders appear only when a concrete need does.

## 4. Component choices

Components (approved 2026-11-01; revisable only through an approved, documented decision — open choices live in the `STATUS.md` backlog until decided, then graduate here):

| Component            | Choice                                                  |
| -------------------- | ------------------------------------------------------- |
| Dotfiles deployment  | GNU Stow                                                |
| Terminal emulator    | ghostty                                                 |
| Git TUI              | lazygit                                                 |
| Compositor           | Hyprland                                                |
| Console font         | Terminus (ter-128n)                                     |
| Terminal font        | Geist Mono (Nerd, SS11 ligatures)                       |
| Color system         | matugen (Material You, generated from the wallpaper)    |
| Status bar           | waybar                                                  |
| App launcher         | fuzzel                                                  |
| Wallpaper daemon     | awww (formerly swww)                                    |
| Web browser          | Brave                                                   |
| Text editor          | Neovim                                                  |
| Shell                | fish                                                    |
| File manager         | superfile                                               |
| AUR helper           | paru                                                    |
| Wi-Fi management     | wlctl (NetworkManager backend; nmtui stays as fallback) |
| Bluetooth management | bluetuith                                               |

## 5. Visual identity

matugen generates a Material You scheme from the current wallpaper — the single color source. Every component consumes it through matugen templates; application configs never hard-code color values.  

Dark scheme by default; automated dark/light switching is out of scope for the initial phase.  

## 6. Repo layout

Target layout (files appear when the project needs them):

- `README.md` — project requirements; source of truth.
- `AGENTS.md` — operating guide for AI agents.
- `STATUS.md` — live state: component inventory, deferred validations, decision backlog.
- `HARDWARE.md` — verified hardware facts and base-system baseline.
- `install.sh` — system provisioning: packages (official repos and AUR), AUR helper setup, services, required system file changes.
- `deploy.sh` — user-level dotfiles deployment: stows every package in `dotfiles/` into `$HOME`. Companion to `install.sh`; run it without sudo.
- `dotfiles/` — application configuration, organized by application, reusable on other machines.

## 7. Working rules

- Session-driven, no fixed roadmap: the user sets each session's scope — new components, deepening existing ones, or as much as desired.
- Component dependencies are constraints, not a sequence. Components may land at **basic** depth (installed, minimal usable configuration) and be deepened later (**deep**: theming, keybinds, full integration).
- `STATUS.md` records the state and depth reached.
- System changes belong in `install.sh`; application configuration in `dotfiles/` — never mixed.
- A system change applied during a session is captured in `install.sh` in the same change set; a manual change missing from the script is a bug.
- Keep `install.sh` simple, readable, and safe to re-run when practical.
- Document required packages, services, and inter-component dependencies as they are introduced.
- Never include secrets or personal data in shared configuration.
- Version control: the agent prepares changes in the working tree; the user reviews, validates, and creates all commits.
