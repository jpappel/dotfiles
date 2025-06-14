local M = {}


local WalTheme = {
    Colorscheme = {
        background = '#011111',
        foreground = '#cfc797',

        cursor_bg = '#732d35',
        cursor_fg = '#e4a44d',
        compose_cursor = '#e4a44d',

        cursor_border = '#732d35',

        selection_bg = '#003136',
        ansi = {
            '#091919', -- black
            '#732d35', -- red
            '#438566', -- green
            '#ab710e', -- yellow
            '#254e76', -- blue
            '#643875', -- purple
            '#136783', -- cyan
            '#bfc3c3', -- white
        },
        brights = {
            '#556767',
            '#945d63',
            '#7ba47d',
            '#e4a44d',
            '#49698f',
            '#815e8a',
            '#498ba1',
            '#e6e7e7',
        },

        visual_bell = '#732d35',

        tab_bar = {
            background = '#011111',

            active_tab = {
                bg_color = '#438566',
                fg_color = '#011111',
            },

            inactive_tab = {
                bg_color = '#003136',
                fg_color = '#cfc797',
            },
            inactive_tab_hover = {
                bg_color = '#011111',
                fg_color = '#bfc3c3',
            },

            new_tab = {
                bg_color = '#136783',
                fg_color = '#cfc797',
            },
            new_tab_hover = {
                bg_color = '#011111',
                fg_color = '#bfc3c3',
            },
        },
    },
    apply_to_config = function(config)
        config.command_palette_fg_color = '#cfc797'
        config.command_palette_bg_color = '#438566'
    end
}

function M.apply_to_config(config)
    config.color_scheme = 'Wal'
    -- color schemes
    config.color_schemes = {
        ['Wal'] = WalTheme.Colorscheme
    }
    WalTheme.apply_to_config(config)
end

return M
