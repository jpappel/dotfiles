-- modified from https://github.com/VonHeikemen/dotfiles

local Plugins = {}

-- FIXME: plugin not loading correctly

-- Autocompletion
local cmp_plugin = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Sources
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        {'L3MON4D3/LuaSnip'},
    }
}

local user = {autocomplete = true}

table.insert(Plugins, cmp_plugin)

table.insert(Plugins, {
      'aspeddro/cmp-pandoc.nvim',
      enabled = true,
      -- event = 'InsertEnter',
      ft = {'markdown', 'pandoc', 'rmd'},
      dependencies = {
          'nvim-lua/plenary.nvim',
          'jbyuki/nabla.nvim'
      },
      opts = {
          crossref = {
              enable_nabla = true
          }
      }
})

cmp_plugin.config = function()
  user.augroup = vim.api.nvim_create_augroup('compe_cmds', {clear = true})
  vim.api.nvim_create_user_command('UserCmpEnable', user.enable_cmd, {})

  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local select_opts = {behavior = cmp.SelectBehavior.Select}
  local cmp_enable = cmp.get_config().enabled

  user.config = {
    enabled = function()
      if user.autocomplete then
        return cmp_enable()
      end

      return false
    end,
    completion = {
      completeopt = 'menu,menuone',
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'path'},
      { name = 'nvim_lsp'},
      { name = 'buffer', keyword_length = 4},
      { name = 'luasnip'},
      { name = 'cmp_pandoc' },
      { name = 'emoji' },
    },
    window = {
      documentation = {
        border = 'rounded',
        max_height = 15,
        max_width = 50,
        zindex = 50,
      }
    },
    formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
        local menu = {
          nvim_lsp = '[LSP]',
          luasnip = '[Snip]',
          buffer = '[Buffer]',
          path = '[Path]',
          nvim_lua = '[Lua]',
          cmp_pandoc = '[Pandoc]',
          emoiji = '[Emoji]'
        }

        item.menu = menu[entry.source.name]
        return item
      end,
    },
    mapping = {
      ['<C-k>'] = cmp.mapping.scroll_docs(-5),
      ['<C-j>'] = cmp.mapping.scroll_docs(5),

      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),

      -- TODO: test
      -- ['<M-k>'] = cmp.mapping.select_prev_item(select_opts),
      -- ['<M-j>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-a>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<C-d>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<M-u>'] = cmp.mapping(function()
        if cmp.visible() then
          user.set_autocomplete(false)
          cmp.abort()
        else
          user.set_autocomplete(true)
          cmp.complete()
        end
      end),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({select = true})
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        elseif user.check_back_space() then
          fallback()
        else
          user.set_autocomplete(true)
          cmp.complete()
        end
      end, {'i', 's'}),

      ['<S-Tab>'] = cmp.mapping(function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          user.insert_tab()
        end
      end, {'i', 's'}),
    }
  }

  cmp.setup(user.config)
end

function user.set_autocomplete(new_value)
  local old_value = user.autocomplete

  if new_value == old_value then
    return
  end

  if new_value == false then
    -- restore autocomplete in the next word
    vim.api.nvim_buf_set_keymap(
      0,
      'i',
      '<space>',
      '<cmd>UserCmpEnable<cr><space>',
      {noremap = true}
    )

    -- restore when leaving insert mode
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = user.augroup,
      command = 'UserCmpEnable',
      once = true,
    })
  end

  user.autocomplete = new_value
end


function user.check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

function user.enable_cmd()
  if user.autocomplete then
    return
  end

  pcall(vim.api.nvim_buf_del_keymap, 0, 'i', '<Space>')
  user.set_autocomplete(true)
end

function user.insert_tab()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<Tab>', true, true, true),
    'n',
    true
  )
end

-- return Plugins

return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },
    -- completion sources
    {
        'hrsh7th/cmp-path',
    },
    {
        'saadparwaiz1/cmp_luasnip'
    },
    { -- TODO: lazy load on filtetype
        'hrsh7th/cmp-nvim-lua'
    },
    {
        -- TODO: lazy load on lsp load
        'hrsh7th/cmp-nvim-lsp',
        dependencies= {
            'neovim/nvim-lspconfig'
        },
    },
    {
        'hrsh7th/cmp-buffer',
    },
    {
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
                    { name = 'nvim_lsp'},
                    { name = 'luasnip'},
                    { name = 'path' },
                    { name = 'nvim_lua' },
                    { name = 'buffer', keyword_length = 4 },
                    { name = 'emoji' }
                },
                window = {
                    -- TODO: style cmp windows
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-k>'] = cmp.mapping.scroll_docs(-5),
                    ['<C-j>'] = cmp.mapping.scroll_docs(5),
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({select = true })
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                })
            })
        end
    },

    -- {
    --     'kdheepak/cmp-latex-symbols',
    --     dependencies = { 'hrsh7th/nvim-cmp' }
    -- },
}
