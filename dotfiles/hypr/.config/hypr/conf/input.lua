-- Input — stock example values with kb_layout set to the physical
-- keyboard ([TWEAK]: es; stock is "us").
-- https://wiki.hypr.land/configuring/core/devices/

hl.config({
    input = {
        kb_layout  = "es",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Gestures — stock example.
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config — stock example block, commented out here
-- (it targets a placeholder device that does not exist on this machine).
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })
