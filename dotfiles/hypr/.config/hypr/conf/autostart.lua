-- Autostart — [TWEAK] session plumbing: the polkit agent draws the
-- password prompts inside the graphical session (without it, polkit
-- requests from GUI apps fail silently).
-- Pattern: https://wiki.hypr.land/configuring/core/autostart/

-- Full path: the binary lives in /usr/lib, not in PATH (the bare name
-- fails with "No such file or directory" and the agent never starts).
-- waybar: the status bar (see dotfiles/waybar).
-- clipboard watchers (wiki.hypr.land pattern): wl-paste --watch fires
-- cliphist store on every CLIPBOARD change — one per type, both are
-- required (text and image). This event spawns once per session: a
-- config reload does not re-run it (no duplicate watchers).
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
