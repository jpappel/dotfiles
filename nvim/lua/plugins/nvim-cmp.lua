local icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

local luasnip = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    keys = {
        {
            '<c-j>',
            function()
                local ls = require('luasnip')
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end,
            mode = { 'i', 's' },
            desc = 'Previous snippet jump'
        },
        {
            '<c-k>',
            function()
                local ls = require('luasnip')
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end,
            mode = { 'i', 's' },
            desc = 'Next snippet jump'
        }
    },
    lazy = true
}

local cmp_path = {
    'hrsh7th/cmp-path',
    event = 'InsertEnter'
}

local cmp_luasnip = {
    'saadparwaiz1/cmp_luasnip',
    dependencies = { "L3MON4D3/LuaSnip" },
    event = 'InsertEnter'
}

local cmp_lua = {
    'hrsh7th/cmp-nvim-lua',
    ft = {
        "lua", "vim"
    }
}

local cmp_pandoc = {
    'aspeddro/cmp-pandoc.nvim',
    -- FIXME: weird issues when using bibliographies
    enabled = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    -- ft = { 'pandoc', 'markdown', 'rmd' }
    opts = {
        bibliography = {
            documentation = true,
        },
        crossref = {
            documentation = true,
            enable_nabla = false
        }
    }
}

local cmp_lsp = {
    'hrsh7th/cmp-nvim-lsp',
    event = 'LspAttach',
    dependencies = {
        'neovim/nvim-lspconfig'
    },
}

local cmp_buffer = {
    'hrsh7th/cmp-buffer',
    event = 'BufEnter'
}

local cmp = {
    'hrsh7th/nvim-cmp',
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path',    keyword_length = 2 },
                { name = 'buffer',  keyword_length = 4 },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered()
            },
            formatting = {
                -- fields = {'menu', 'abbr', 'kind'},
                format = function(entry, item)
                    -- item.kind = string.format('%s %s', icons[item.kind], item.kind)
                    item.kind = icons[item.kind] .. ' ' .. item.kind
                    local menu = {
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snip]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                        nvim_lua = '[Lua]',
                        cmp_pandoc = '[Pandoc]',
                        emoiji = '[Emoji]',
                    }
                    menu['vim-dadbod-completion'] = '[dadbod]'
                    item.menu = menu[entry.source.name]
                    return item
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.scroll_docs(-5),
                ['<C-j>'] = cmp.mapping.scroll_docs(5),
                ['<TAB>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { 'i', 's' })
            })
        })
        cmp.setup.filetype({ 'pandoc', 'markdown', 'rmd' }, {
            sources = {
                { name = 'luasnip' },
                { name = 'path',   keyword_length = 3 },
                { name = 'buffer' },
                { name = 'emoji' },
                -- { name = 'cmp_pandoc' },
            }
        })
        cmp.setup.filetype({ "lua", "vim" }, {
            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'buffer' },
                { name = 'path' }
            }
        })
        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = 'vim-dadbod-completion' },
                { name = 'nvim_lsp' },
                { name = 'buffer' }
            }
        })
    end
}

return {
    luasnip,
    -- completion sources
    cmp_path,
    cmp_luasnip,
    cmp_lua,
    cmp_lsp,
    cmp_buffer,
    -- cmp_pandoc,
    cmp,
}
