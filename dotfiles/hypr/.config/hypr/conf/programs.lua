-- Programs — [TWEAK] our component choices (README § Component choices).
-- All three live: fsel in a floating ghostty (SUPER+SPACE), ghostty
-- itself (SUPER+RETURN), and superfile (SUPER+E — its binary is spf,
-- not superfile). fileManager is a TUI: binds.lua launches it through
-- the terminal wrapper (ghostty -e) — a bare TUI exec has no TTY and
-- dies instantly.

return {
    terminal    = "ghostty",
    fileManager = "spf",         -- binary: spf — see pacman -Ql superfile
    menu        = "ghostty --class=appicker -e fsel -d",  -- fsel TUI launcher in a floating
                  -- ghostty (rule in conf/rules.lua). -d/--detach: launched apps
                  -- survive the picker closing — they are NOT children the
                  -- terminal kills on exit. (fuzzel remains installed during a
                  -- grace period — README § Component choices: App launcher)
}
