local colorschemes = {
    catppuccin = {
        "catppuccin/nvim",
        name = "catpuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme catppuccin-mocha]]
        end
    },
    wal = {
        "mbrea-c/wal-colors.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme mbc]]
        end,
    },
    tokyonight = {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
        end
    },
    everforest_lua = {
        'neanias/everforest-nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                background = "hard",
                transparent_background_level = 0
            })
            vim.cmd [[highlight! link TroubleNormal Normal]]
            vim.cmd [[highlight! link TroubleNormalNC Normal]]
            vim.cmd [[colorscheme everforest"]]
        end
    },
    evergarden = {
        'comfysage/evergarden',
        lazy = false,
        priority = 1000,
        config = function()
            require('evergarden').setup({
                transparent_background = false,
                contrast_dark = 'hard',
                style = {
                    tabline = { reverse = true, color = 'green' },
                    search = { reverse = true, inc_reverse = true },
                }
            })
            vim.cmd("colorscheme evergarden")
        end
    },
    miasma = {
        "xero/miasma.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme miasma")
        end,
    }
}

local colorsProfiles = require("profiles").createProfiles(colorschemes.catppuccin)

colorsProfiles["nest"] = colorschemes.evergarden

return colorsProfiles[HOSTNAME]
