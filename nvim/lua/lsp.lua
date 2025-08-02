vim.lsp.config('*', {
    root_markers = { '.git' },
})
vim.lsp.enable({
    "gopls",
    "clangd",
    "lua_ls",
})
