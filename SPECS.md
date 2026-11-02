# SPECS.md — Customizing a new Arch Linux installation

## 1. Objective

Progressively configure a personal Arch Linux workstation, starting from a clean installation and building a functional, lightweight, consistent, maintainable environment tailored to the user's needs.

OpenCode and the available AI models will act as technical assistants throughout the project. Work may span one or several sessions, potentially with different models; the user defines each session's scope (see §5).

## 2. Reference Hardware

- **Device:** Dell XPS 13 9350.
- **CPU:** 6th-generation Intel Core i7.
- **RAM:** 16 GB.
- **Display:** QHD.
- **Operating system:** Vanilla Arch Linux.

Technical decisions must account for the hardware's capabilities. Before making hardware-dependent decisions, inspect the system's actual state. Shared configuration must distinguish general settings from machine-specific ones. The verified hardware inventory and base-system baseline are recorded in `HARDWARE.md`.

## 3. Desktop Environment and Tools

- Configuration will be developed incrementally, introducing components as actual needs arise.
- Prefer lightweight, maintainable solutions that integrate well with Wayland and Hyprland.
- Component choices are premises (table below), not assumptions: they were approved by the user and are revisable only through a documented decision. Open choices live in the STATUS.md decision backlog until decided, then graduate here.

### Chosen components (premises)

Approved 2026-11-01.

| Component | Choice |
|---|---|
| Compositor | Hyprland |
| Terminal emulator | ghostty |
| Color system | matugen (Material You, generated from the wallpaper) |
| Status bar | waybar |
| App launcher | fuzzel |
| Wallpaper daemon | awww (formerly swww) |
| Web browser | Brave |
| Text editor | Neovim |
| Shell | fish |
| File manager | superfile |
| AUR helper | paru |
| Wi-Fi management | wlctl (NetworkManager backend; nmtui stays as fallback) |
| Bluetooth management | bluetuith |

### Design Principles

- **Simplicity:** Prefer explicit, understandable configurations. Avoid unnecessary abstractions, layers, and dependencies.
- **Performance:** Choose components suited to the available hardware and minimize resource usage without sacrificing responsiveness or stability for marginal visual improvements.
- **Tools:** Prefer TUI applications when appropriate, but do not rule out GUI applications that offer clear functional, integration, or usability advantages.
- **Visual consistency:** Maintain a unified visual identity across applications and system components, prioritizing readability, contrast, and performance.
- **Maintainability:** Make configurations easy to understand and modify manually.

## 4. Visual Identity

The color system is dynamic: matugen generates a Material You scheme
from the current wallpaper, and every component consumes that generated
scheme through matugen templates (terminal, shell, TUI applications,
text editor, file manager, bar, launcher, notifications, lock screen,
and the compositor itself).

- The matugen configuration is the single source of color definitions.
  Application configs never hard-code color values; they consume
  generated files.
- Default: dark scheme. A light variant remains available through
  matugen's scheme configuration; an automated dark/light switch stays
  out of the initial phase.
- Atom One Dark/Light were the reference palettes until 2026-11-01,
  when the matugen pipeline superseded them (user decision).

## 5. Session-driven Planning

Work is organized by user-defined sessions, not a fixed roadmap. At the
start of each session the user sets its scope: install new components,
deepen existing ones, or finish as much as desired — possibly the whole
system. Sessions may be one or many, with one or several models.

- Dependencies are constraints, not a sequence: before proposing, the
  agent checks the session scope against the component constraints
  recorded in STATUS.md and surfaces prerequisites or conflicts.
- A component may land at basic depth (installed, minimal usable
  configuration) and be deepened later (theming, keybinds, full
  integration); both are valid stopping points. The depth reached is
  recorded in the STATUS.md inventory.
- STATUS.md is the single progress truth: component states, deferred
  validations, decisions, and the decision backlog. A session is not
  closed until it reflects the actual system state.

Each component, whenever it is worked on, must define:

- A clear objective.
- Its dependencies and constraints.
- Its configuration and design decisions.
- Appropriate validation criteria — or a registered deferred validation
  when validation is not possible yet.
- Its final status and outstanding tasks.

## 6. Reproducibility

The configuration must be reasonably portable to other machines and adaptable without relying on the reference hardware.

To achieve this:

- Maintain an installation script and extend it as new packages are introduced.
- Organize and reuse configuration files (*dotfiles*).
- Document required packages, tools, services, and inter-module dependencies.
- Separate general configuration from hardware-specific settings.
- Avoid undocumented manual changes.
- Exclude secrets and personal data from shared configuration.

No specific *dotfiles* management tool is required initially.

## 7. Version Control

Use Git to preserve project progress and review changes.

The agent may prepare modifications in the working tree, but the user is responsible for reviewing and validating them and for creating all commits. Implementing a specific version-recovery strategy is not an independent project objective.

## 8. Workflow

Follow an incremental process within each session:

1. Read STATUS.md; summarize the current state (component inventory, deferred validations, decision backlog) and ask the user for the session scope.
2. Check the scope against component constraints; surface prerequisites or conflicts.
3. Inspect the system's current state (read-only) and research as needed.
4. Propose a solution and obtain authorization before modifying the system.
5. Implement only approved changes.
6. Validate the results — or register a deferred validation when validation is not possible yet.
7. Document decisions and the final configuration.
8. Update STATUS.md: inventory states and depths, deferred validations, decisions, backlog. A session is not closed until STATUS.md reflects the actual system state.

Components may be left at basic depth intentionally, to be deepened in a later session; what must never be left behind is an updated STATUS.md.

## 9. Success Criteria and Evolution

The workstation must meet the user's needs, deliver good performance and visual consistency, remain easy to maintain, and be reasonably reproducible on other machines.

The configuration will evolve as new needs emerge. Future features must be introduced deliberately, avoiding premature complexity or automation that does not yet provide a concrete benefit.