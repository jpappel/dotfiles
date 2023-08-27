local lsp = require('lsp-zero')

lsp.preset({})

lsp.ensure_installed({
    'pylsp',
    'gopls',
    'tsserver',
    'rust_analyzer'
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.set_preferences({
    sign_icons = { }
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())


lsp.setup()
