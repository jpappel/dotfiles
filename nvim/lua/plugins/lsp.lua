local lazydev = {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
local lspconfig = {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        lazydev
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
                -- TODO: add fallback to default gd + warning
                vim.lsp.buf.definition()
            end,
            mode = 'n',
            desc = "Go to definition"
        },
        {
            -- TODO: consider changing binding to grf
            '<leader>f',
            function()
                vim.lsp.buf.format()
            end,
            mode = { 'n' },
            desc = "Format entire buffer"
        },
        {
            '<leader>f',
            function()
                local opts = {}
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                for _, client in ipairs(clients) do
                    if client:supports_method("textDocument/rangesFormatting") then
                        local range = require("shared").get_visual_range({})
                        opts.range.start = range.start
                        opts.range["end"] = range.stop
                        break
                    end
                end
                vim.lsp.buf.format(opts)
            end,
            mode = { 'v' },
            desc = "Format visual selection"
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
            "ts_ls"

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
