local lspconfig = {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig'
    },
    keys = {
        {
            'gd',
            function()
                vim.lsp.buf.definition()
            end,
            mode = 'n',
            desc = "Go to definition"
        },
        {
            '<leader>r',
            function ()
                vim.lsp.buf.rename()
            end,
            mode = 'n',
            desc = "Rename symbol"
        },
        {
            '<C-f>',
            function()
                vim.lsp.buf.format()
            end,
            mode = {'n', 'v'},
            desc = "Format code"
        },
        {
            '<leader>la',
            function ()
                vim.lsp.buf.code_action()
            end,
            mode = {'n', 's'},
            desc = "Show code actions"
        },
        {
            '<leader>lr',
            function ()
                vim.lsp.buf.references()
            end,
            mode = 'n',
            desc = "Add symbol references to qf"
        },
        {
            '<C-h>',
            function ()
                vim.lsp.buf.signature_help()
            end,
            mode = 'i',
            desc = "Show signature help"
        }
    }
}

local mason = {
    'williamboman/mason.nvim',
    opts = {}
}

local mason_lspconfig = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    opts = {
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end
        },
        ["lua_ls"] = function ()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            })
        end
    }
}


return {
    mason,
    mason_lspconfig,
    lspconfig,
}
