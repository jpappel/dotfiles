local lspconfig = {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                if client.name == 'ruff' then
                    -- Disable hover in favor of BasedPyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
            desc = 'LSP: Disable hover capability from Ruff',
        })
    end,
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
            function()
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
            mode = { 'n', 'v' },
            desc = "Format code"
        },
        {
            '<leader>la',
            function()
                vim.lsp.buf.code_action()
            end,
            mode = { 'n', 's' },
            desc = "Show code actions"
        },
        {
            '<leader>lr',
            function()
                vim.lsp.buf.references()
            end,
            mode = 'n',
            desc = "Add symbol references to qf"
        },
        {
            '<C-h>',
            function()
                vim.lsp.buf.signature_help()
            end,
            mode = 'i',
            desc = "Show signature help"
        }
    }
}

local mason = {
    'williamboman/mason.nvim',
    opts = {},
    build = ":MasonUpdate"
}

local mason_lspconfig = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    opts = {
        ensure_installed = {
            "basedpyright",
            "clangd",
            "cssls",
            "gopls",
            "html",
            "ruff",
            "tsserver"

        },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
            ["lua_ls"] = function()
                require('lspconfig').lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
            end,
            ["basedpyright"] = function()
                require('lspconfig').basedpyright.setup({
                    settings = {
                        basedpyright = {
                            -- defer to ruff for import oranization
                            disableOrganizeImports = true,
                            analysis = {
                                typeCheckingMode = "standard"
                            }
                        },
                        python = {
                            analysis = {
                                -- Ignore all files for analysis to exclusively use Ruff for linting
                                ignore = { '*' },
                            },
                        },
                    },
                })
            end
        },
    }
}


return {
    mason,
    mason_lspconfig,
    lspconfig,
}
