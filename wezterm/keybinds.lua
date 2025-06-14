local M = {}

local wezterm = require 'wezterm'


local disabled_keys = {
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
}

function M.apply_to_config(config)
    config.leader = {
        key = ';',
        mods = 'CTRL',
    }
    config.keys = {}

    for _, disabled_map in ipairs(disabled_keys) do
        table.insert(config.keys, disabled_map)
    end

    table.insert(config.keys, {
        key = ';',
        mods = 'LEADER',
        action = wezterm.action.ActivateCommandPalette,
    })

end

return M
