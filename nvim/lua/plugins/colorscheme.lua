local colorschemes = {
    catppuccin = {
        "catppuccin/nvim" ,
        name = "catpuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme catppuccin-mocha]]
        end
    },
    wal = {
        "mbrea-c/wal-colors.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme mbc]]
        end,
    },
    tokyonight = {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme tokyonight-night]]
        end
    },
    everforest_lua = {
        'neanias/everforest-nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            require("everforest").setup({
                background = "medium",
                transparent_background_level = 2
            })
            vim.cmd[[highlight! link TroubleNormal Normal]]
            vim.cmd[[colorscheme everforest"]]
        end
    },
    everforest = {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_background = 'hard'
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_transparent_background = 2
            vim.cmd[[colorscheme everforest]]
        end,
    }
}

local colorsProfiles = require("profiles").createProfiles(colorschemes.catppuccin)

colorsProfiles["nest"] = colorschemes.everforest_lua

return colorsProfiles[HOSTNAME]
