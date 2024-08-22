return {
    'stevearc/oil.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = { {
        "<leader>ef",
        function()
            local filetype = vim.o.ft
            if filetype == "oil" then
                vim.cmd('q')
            else
                vim.cmd('topleft vsplit +Oil')
            end
            -- TODO: check for other open oil instances
        end,
        desc = "Open Oil file explorer in a far left split, similar to :Lexplore"
    } },
    cmd = "Oil"
}