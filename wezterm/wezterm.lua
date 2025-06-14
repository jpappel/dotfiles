local wezterm = require 'wezterm'

local config = wezterm.config_builder()

require('keybinds').apply_to_config(config)

-- fonts
config.font_size = 16
config.font = wezterm.font_with_fallback({
    {
        family = "FiraMono Nerd Font",
        weight = "Medium",
        harfbuzz_features = { "ss03" },
    },
    "Noto Color Emoji",
})

-- tab
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- window appearnce
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.75
config.window_decorations = "RESIZE"

-- colors
require('colorscheme').apply_to_config(config)

-- bell settings
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
}

wezterm.on('bell', function(window, pane)
    if pane:has_unseen_output() then
        window:toast_notification("WezTerm: Bell Rung", pane:get_title())
    end
end)

return config
