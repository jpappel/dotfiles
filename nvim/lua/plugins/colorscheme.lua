local colorscheme = {
    lazy = false,
    priority = 1000
}

local catpuccin = {
    "catppuccin/nvim" ,
    name = "catpuccin",
    config = function()
        vim.cmd[[colorscheme catppuccin-mocha]]
    end
}

local tokyonight = {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    config = function()
        vim.cmd[[colorscheme tokyonight-night]]
    end
}

-- combine default colorscheme settings with selected theme
return vim.tbl_extend('force', colorscheme, catpuccin)
