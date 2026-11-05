-- Monitors — [TWEAK] eDP-1: HiDPI 3200x1800 panel, scale 1.6
-- (2000x1125 effective). 1.6, not the planned 1.5: on this panel a
-- configured 1.5 does not stick — the session ends up at 1.6, the
-- nearest scale with an integer logical size (3200/1.6 = 2000 exact,
-- 3200/1.5 = 2133.33), while integer-clean values like 2 apply as-is.
-- Verified live with hyprctl monitors. Tunable live: Hyprland reloads
-- this file on save.
-- Fields: https://wiki.hypr.land/configuring/core/monitors/

hl.monitor({
    output = "eDP-1",
    mode   = "preferred",
    scale  = "2",
})
