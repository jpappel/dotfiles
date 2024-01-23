local lsp = require('lsp-zero')

lsp.preset({})

lsp.ensure_installed({
    'pylsp',
    'html',
    'clangd',
    -- 'sqlls',
    'cssls',
    -- 'java_language_server',
    -- 'ltex',
    'lua_ls',
    --'gopls',
    'tsserver',
    --'rust_analyzer'
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.set_preferences({
    sign_icons = { }
})


-- LS configs
--
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- TODO: change bind for lsp.buf.code_actions()


lsp.setup()
