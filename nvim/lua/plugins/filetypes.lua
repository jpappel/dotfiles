return {
    {
        "tpope/vim-dadbod",
        lazy = true
    },
    {
        'ap/vim-css-color',
        ft = { 'css', 'scss', 'sass' }
    },
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            "tpope/vim-dadbod",
            'kristijanhusak/vim-dadbod-completion'
        },
        keys = {
            { '<leader>sf', vim.cmd.DBUIToggle, desc = "Toggle dadbod ui" },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    }
}
