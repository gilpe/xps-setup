# AGENTS.md — Operating guide for AI agents

How any AI agent must behave in this repository. Read README.md first —
it is the source of truth (premises and design principles §3, visual
identity §4, working model §5, repo rules §6); on conflict, README.md
wins. Verified hardware facts: HARDWARE.md. Live project state:
STATUS.md.

## Interaction rules

- Communicate with the user in Spanish. Write repository documentation
  in English.
- Never modify the system without explicit approval. Propose first:
  commands, packages, and file changes — what, why, alternatives, how
  to validate.
- Privileged operations (sudo, pacman, service changes) always require
  explicit authorization. Read-only inspection is fine.
- If an operation is blocked by missing permissions, ask the user and
  wait. Never improvise silent workarounds.
- When a privileged step cannot be executed directly (e.g., sudo
  prompts for a password), split it into sub-steps: prepare everything,
  hand over the exact command(s) to run in the user's terminal, then
  verify the outcome once they report back.
- The agent prepares changes in the working tree; the user reviews,
  validates, and commits. Never commit, push, or tag.

## Workflow per session

1. Read STATUS.md; summarize the current state (inventory, deferred
   validations, backlog) and ask the user for the session scope.
2. Check the scope against component constraints; surface prerequisites
   or conflicts. Dependencies are constraints, not an order.
3. Inspect the current system state (read-only); research alternatives.
4. Propose a solution and wait for authorization.
5. Implement only the approved changes.
6. Validate the results — or register a deferred validation in
   STATUS.md.
7. Document decisions and the final configuration: premises → README,
   hardware facts → HARDWARE.md, open questions → STATUS.md backlog.
8. Update STATUS.md (inventory states and depths, deferred validations,
   backlog). A session is not closed until it reflects the actual
   system state.

Components may land at basic depth and be deepened in a later session;
record the depth reached. The only step that must never be postponed is
the STATUS.md update.

## STATUS.md maintenance

- Three parts: component inventory (state — not installed · basic ·
  deep — plus constraints), deferred validations, decision backlog.
- State only. Tool premises live in README.md §3; an open choice is a
  backlog row until decided, then graduates there.
- The single home for open items; reference documents (e.g.,
  HARDWARE.md) carry no TODOs.
- Update it before ending a session. When reading it, verify against
  the actual system and correct anything stale — it is a live view, not
  an archive.

## Hard don'ts

- Don't commit or push.
- Don't modify the system without approval.
- Don't apply a system change without capturing it in `install.sh`.
- Don't assume tools or components without an approved proposal.
- Don't duplicate color or theme definitions.
- Don't add automation without an established, concrete need.
- Don't make undocumented manual changes.
