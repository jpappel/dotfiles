return {
    'nvim-lualine/lualine.nvim', -- lualine
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
            options = {
                theme = 'auto',
                globalstatus = true,
            },
            -- tabline = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = {},
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            -- winbar = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = {'filename'},
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            -- inactive_winbar = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = {'filename'},
            --     lualine_x = {'location'},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
        },
}
