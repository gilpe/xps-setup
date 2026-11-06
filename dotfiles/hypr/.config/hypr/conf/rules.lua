-- Window and workspace rules — stock example values.
-- https://wiki.hypr.land/configuring/core/rules/

-- "Smart gaps" / "No gaps when only" — stock example, commented upstream.
-- Uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- Ignore maximize requests from all apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Clipboard picker: ghostty opened with --class=clipicker by the
-- SUPER+H bind. Floating + sized close to the picker's natural TUI
-- proportions so it doesn't tile.
hl.window_rule({
    name  = "clipboard-picker",
    match = { class = "clipicker" },

    float = true,
    size  = "622 652",
})

-- App launcher: fsel TUI opens with --class=appicker (SUPER+SPACE).
-- Same floating-picker pattern as the clipboard picker above.
hl.window_rule({
    name  = "app-launcher",
    match = { class = "appicker" },

    float = true,
    size  = "622 652",
})
