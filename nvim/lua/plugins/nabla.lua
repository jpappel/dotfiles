return {
    'jbyuki/nabla.nvim',
    enabled = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    ft = { 'markdown', 'pandoc', 'rmd' },
    keys = {
        {
            "<Leader>=p",
            function()
                require('nabla').popup()
            end,
            desc = "Popup Nabla equation preview"
        },
        {
            "<Leader>==",
            function()
                require('nabla').toggle_virt()
            end,
            desc = "Toggle Nabla equation preview for the entire buffer"
        }
    }
}
