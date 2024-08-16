local dadbod = {
    "tpope/vim-dadbod",
    lazy = true
}
local dadbod_completions = {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'mysql', 'plsql' },
    lazy = true
}
local dadbod_ui = {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        dadbod,
        dadbod_completions
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
return {
    dadbod_ui,
}
