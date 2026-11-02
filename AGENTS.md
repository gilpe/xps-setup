# AGENTS.md — Operating guide for AI agents

How any AI agent must behave while working in this repository.
For project requirements and rationale, read SPECS.md first — it is the
source of truth. If this file and SPECS.md conflict, SPECS.md wins.

## Project context

- Incremental configuration of a personal Arch Linux workstation, built
  session by session: the user defines each session's scope, potentially
  with different models.
- Reference hardware: Dell XPS 13 9350 (6th-gen Core i7, 16 GB RAM, QHD
  display), vanilla Arch Linux. Inspect the real system state before any
  hardware-dependent decision; prefer read-only commands. Never assume.
- Keep general configuration separate from machine-specific settings.

## Interaction rules

- Communicate with the user in Spanish. Write repository documentation in English.
- Never modify the system without explicit approval. Propose first: commands,
  packages, and file changes.
- Privileged operations (sudo, pacman, service changes) always require explicit
  authorization. Read-only inspection is fine.
- If an operation is blocked by missing permissions, ask the user for them
  and wait — the user can grant them. Never improvise silent workarounds.
- When a privileged step cannot be executed directly (e.g., sudo prompts
  for a password), split the task into sub-steps to give the user an
  intervention point: prepare everything, hand over the exact command(s)
  to run in their terminal, then verify the outcome once they report back.
- The agent prepares changes in the working tree. The user reviews, validates,
  and creates all commits. Never commit, push, or tag.
- Keep proposals concise: what, why, alternatives considered, how to validate.

## Design principles (checklist)

- Simplicity: explicit, understandable configs. No unnecessary abstractions,
  layers, or dependencies.
- Performance: lightweight components suited to this hardware. No marginal
  visual gains at the cost of responsiveness or stability.
- Wayland/Hyprland compatible by default. Prefer TUI where practical, but
  choose GUI when it offers clear advantages.
- Visual consistency: the matugen-generated scheme (from the current
  wallpaper) is the single color source. Define colors once in matugen
  templates; never hard-code color values in application configs.
- No premature complexity or automation. Automated theme switching is
  explicitly out of scope for the initial phase.
- Component choices are premises recorded in SPECS.md §3. Introduce or
  change tools only through an approved, documented decision; open choices
  live in the STATUS.md decision backlog.

## Workflow per session

1. Read STATUS.md; summarize the current state (component inventory,
   deferred validations, decision backlog) and ask the user for the
   session scope.
2. Check the scope against component constraints; surface prerequisites
   or conflicts. Dependencies are constraints, not an order.
3. Inspect the current system state (read-only); research alternatives.
4. Propose a solution and wait for authorization.
5. Implement only the approved changes.
6. Validate the results — or register a deferred validation in STATUS.md
   when validation is not possible yet.
7. Document decisions and the final configuration.
8. Update STATUS.md (inventory states and depths, deferred validations,
   decisions, backlog). A session is not closed until STATUS.md reflects
   the actual system state.

Components may land at basic depth and be deepened in a later session;
record the depth reached. The only step that must never be postponed is
the STATUS.md update.

## Repo layout and reproducibility

Target layout (files appear when the project needs them):

- `SPECS.md` — project requirements; source of truth.
- `AGENTS.md` — this guide.
- `STATUS.md` — lightweight progress log (see below).
- `HARDWARE.md` — verified hardware inventory and base-system baseline
  (reference data for hardware-dependent decisions).
- `install.sh` — system provisioning: everything that is NOT application
  configuration. Package installation (official repos and AUR), AUR helper
  setup, enabling services, required system file changes (e.g., /etc).
- `dotfiles/` — application configuration (Hyprland, shell, editor, ...),
  organized by application, reusable on other machines.

Reproducibility rules:

- Two kinds of changes, never mixed: system changes belong in `install.sh`;
  application configuration belongs in `dotfiles/`.
- If a system change is applied during a session, capture it in `install.sh`
  as part of the same change set. A manual change missing from the script is
  a bug — the goal is a setup replicable on other machines.
- Keep `install.sh` simple, readable, and safe to re-run when practical.
- Separate general configuration from machine-specific settings in both.
- Document required packages, services, and inter-component dependencies
  as they are introduced.
- Never include secrets or personal data in shared configuration.

## STATUS.md

- The single, lightweight progress log, in four parts: the component
  inventory (flat table: state per component — not installed, basic,
  deep — plus constraints), the deferred-validations registry, the
  decisions log, and the decision backlog. Keep it short — it exists so
  any future session or model can pick up where the last one stopped.
- Tool choices are premises in SPECS.md §3; STATUS.md tracks state only.
  An open choice is a backlog row until decided; once decided, it
  graduates to the SPECS.md premises table via a decision entry.
- It is the single home for open items (deferred validations, decision
  backlog); reference documents (e.g., HARDWARE.md) do not carry TODO
  lists.
- Read it at the start of every session. Update it before ending: a
  session is not closed until STATUS.md reflects the actual system state.
- When reading STATUS.md, verify its contents against the actual system
  state (inventory states, deferred validations, backlog rows) and
  correct anything stale. It is a live view, not an archive.

## Hard don'ts

- Don't commit or push.
- Don't modify the system without approval.
- Don't apply a system change without capturing it in `install.sh`.
- Don't assume tools or components without an approved proposal.
- Don't duplicate color or theme definitions.
- Don't add automation without an established, concrete need.
- Don't make undocumented manual changes.
