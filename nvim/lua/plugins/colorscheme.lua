return {
    {
        "catppuccin/nvim" ,
        name = "catpuccin",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            vim.cmd[[colorscheme catppuccin-mocha]]
        end
    },
    {
        "mbrea-c/wal-colors.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme mbc]]
        end,
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme tokyonight-night]]
        end
    }
}
