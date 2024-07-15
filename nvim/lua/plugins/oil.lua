return {
    'stevearc/oil.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = { {
        "<leader>ef",
        function()
            vim.cmd('topleft vsplit +Oil')
        end,
        desc = "Open Oil file explorer in a far left split, similar to :Lexplore"
    } },
    cmd = "Oil"
}
