local M = {}

local wezterm = require 'wezterm'

function M.apply_to_config(config)
    config.leader = {
        key = ';',
        mods = 'CTRL',
    }
    config.keys = {
        {
            key = 'M',
            mods = 'CTRL',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'P',
            mods = 'CTRL',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'X',
            mods = 'CTRL',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = ';',
            mods = 'LEADER',
            action = wezterm.action.ActivateCommandPalette,
        },
        {
            key = '[',
            mods = 'LEADER',
            action = wezterm.action.ActivateCopyMode,
        },
        {
            key = '/',
            mods = 'LEADER',
            action = wezterm.action.Search({ CaseInSensitiveString = ''})
        },
    }
end

return M
