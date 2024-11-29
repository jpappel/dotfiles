return {
    {
        'habamax/vim-godot',
        ft = 'gdscript'
    },
    {
        'vim-pandoc/vim-pandoc',
        enabled = false,
        ft = { "markdown", "pandoc" },
        keys = {
            { 'gO', vim.cmd.TOC, desc = "Table of contents" }
        }
    },
    {
        'vim-pandoc/vim-pandoc-syntax',
        ft = { "markdown", "pandoc" }
    },
    {
        "tpope/vim-dadbod",
        lazy = true
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
