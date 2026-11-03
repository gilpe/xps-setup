-- Autostart — [TWEAK] session plumbing: the polkit agent draws the
-- password prompts inside the graphical session (without it, polkit
-- requests from GUI apps fail silently).
-- Pattern: https://wiki.hypr.land/configuring/core/autostart/

-- Full path: the binary lives in /usr/lib, not in PATH (the bare name
-- fails with "No such file or directory" and the agent never starts).
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)
