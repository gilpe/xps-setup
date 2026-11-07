-- Programs — [TWEAK] our component choices (README § Component choices).
-- All three live: the launcher composition (SUPER+SPACE), ghostty
-- itself (SUPER+RETURN), and superfile (SUPER+E — its binary is spf,
-- not superfile). fileManager is a TUI: binds.lua launches it through
-- the terminal wrapper (ghostty -e) — a bare TUI exec has no TTY and
-- dies instantly.

return {
    terminal    = "ghostty",
    fileManager = "spf",         -- binary: spf — see pacman -Ql superfile
    -- App launcher: j4-dmenu-desktop (parses .desktop files, --usage-log
    -- sorts by frequency) feeding fzf (README § Design principles:
    -- Tools) inside the floating ghostty of class "appicker" (rule in
    -- conf/rules.lua). --no-generic: j4 emits each app twice by default
    -- (Name + GenericName as separate entries) — one entry per app.
    -- --term-mode custom starts Terminal=true apps with setsid ghostty:
    -- j4 waits for its child, so bare ghostty kept the picker open
    -- while the terminal app ran — setsid forks/detaches and j4's wait
    -- returns instantly (picker closes, the app lives reparented).
    -- fsel TUI was evaluated and retired (icons not a felt need,
    -- maturity risk); fuzzel retired before it.
    menu        = "ghostty --class=appicker -e sh -c 'j4-dmenu-desktop --no-generic --dmenu=\"fzf --no-sort\" --term-mode custom --term \"setsid ghostty -e {cmdline@}\" --usage-log ~/.cache/j4-dmenu-desktop.log'",
}
