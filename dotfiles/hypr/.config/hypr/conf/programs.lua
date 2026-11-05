-- Programs — [TWEAK] our component choices (README § Component choices).
-- All three live: fuzzel (SUPER+SPACE), ghostty (SUPER+RETURN), and
-- superfile (SUPER+E — its binary is spf, not superfile). fileManager
-- is a TUI: binds.lua launches it through the terminal wrapper
-- (ghostty -e) — a bare TUI exec has no TTY and dies instantly.

return {
    terminal    = "ghostty",
    fileManager = "spf",         -- binary: spf — see pacman -Ql superfile
    menu        = "fuzzel",
}
