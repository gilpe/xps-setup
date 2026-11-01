# SPECS.md — Customizing a new Arch Linux installation

## 1. Objective

Progressively configure a personal Arch Linux workstation, starting from a clean installation and building a functional, lightweight, consistent, maintainable environment tailored to the user's needs.

OpenCode and the available AI models will act as technical assistants throughout the project. Work will span multiple independent sessions, potentially using different models, without requiring the entire configuration to be completed in a single session.

## 2. Reference Hardware

- **Device:** Dell XPS 13 9350.
- **CPU:** 6th-generation Intel Core i7.
- **RAM:** 16 GB.
- **Display:** QHD.
- **Operating system:** Vanilla Arch Linux.

Technical decisions must account for the hardware's capabilities. Before making hardware-dependent decisions, inspect the system's actual state. Shared configuration must distinguish general settings from machine-specific ones. The verified hardware inventory and base-system baseline are recorded in `HARDWARE.md`.

## 3. Desktop Environment and Tools

- **Compositor:** Hyprland.
- Configuration will be developed incrementally, introducing components as actual needs arise.
- Prefer lightweight, maintainable solutions that integrate well with Wayland and Hyprland.
- Do not assume in advance which display manager, terminal, shell, text editor, file manager, or notification system will be used.

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

## 5. Modularity and Planning

Organize the work into independent modules that can be addressed across separate sessions. Initial modules may include:

- Base system and hardware diagnostics.
- Hyprland and desktop environment.
- Terminal and shell.
- Text editor.
- File manager.
- Notifications and screen locking.
- Audio, networking, connectivity, and peripherals.
- Productivity tools.
- Appearance and customization.

The final module list, order, and scope will be determined as the project evolves.

Establish an implementation order based on dependencies, importance, and usefulness for subsequent tasks. For example, configuring a text editor first may make it easier to configure Hyprland, even if completing the desktop environment is a higher priority.

Each module must define:

- A clear objective.
- Its dependencies.
- Its configuration and design decisions.
- Appropriate validation criteria.
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

Follow an incremental process for each module:

1. Inspect the system's current state.
2. Identify requirements, constraints, and dependencies.
3. Research relevant alternatives.
4. Propose a solution and obtain authorization before modifying the system.
5. Implement only approved changes.
6. Validate the results.
7. Document decisions and the final configuration.
8. Update project status and outstanding tasks for future sessions.

Aim to complete and validate each module before moving on, respecting dependencies while maintaining an overall view of the system.

## 9. Success Criteria and Evolution

The workstation must meet the user's needs, deliver good performance and visual consistency, remain easy to maintain, and be reasonably reproducible on other machines.

The configuration will evolve as new needs emerge. Future features must be introduced deliberately, avoiding premature complexity or automation that does not yet provide a concrete benefit.