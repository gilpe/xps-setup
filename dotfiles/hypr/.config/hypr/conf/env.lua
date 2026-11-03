-- Environment variables — stock example values.

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Permissions — stock example, commented upstream. Changes here require
-- a Hyprland restart; they are not applied on-the-fly for security
-- reasons.
-- https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
