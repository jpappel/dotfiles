return {
    'tpope/vim-fugitive', -- close to native git command integrations
    keys = {
        {"<leader>gs", vim.cmd.Git, desc = "Git Status"}
    }
}
