local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

lsp_zero.preset({})

lsp_zero.ensure_installed({
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

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.set_preferences({
    sign_icons = { }
})


-- LS configs
--
lsp_config.lua_ls.setup(lsp_zero.nvim_lua_ls())
lsp_config.texlab.setup({})

-- TODO: change bind for lsp.buf.code_actions()


lsp_zero.setup()
