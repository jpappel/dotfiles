return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- package manager
    use 'neovim/nvim-lspconfig' -- config for lsp

    -- common dependacy
    use "nvim-lua/plenary.nvim"

    -- git
    use 'tpope/vim-fugitive' -- close to native git command integrations


    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',   -- fuzzy finder
        requires = { {'nvim-lua/plenary.nvim'}, {'nvim-tree/nvim-web-devicons'} }
    }

    -- completion
    -- TODO:config completion and setup binds
    use 'hrsh7th/nvim-cmp'
    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = { {'hrsh7th/nvim-cmp'}, {'neovim/nvim-lspconfig'} }
    }
    use {
        'hrsh7th/cmp-path',
        requires = { 'hrsh7th/nvim-cmp' }
    }
    use {
        'kdheepak/cmp-latex-symbols',
        requires = { 'hrsh7th/nvim-cmp' }
    }


    -- pandoc
    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'numToStr/Comment.nvim', -- faster commentting
        config = function()
            require('Comment').setup()
        end
    }

    use 'habamax/vim-godot'

    -- TODO: configure tree-sitter to color current indentation level
    use {
        'lukas-reineke/indent-blankline.nvim', -- show indentation levels
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
                show_current_context_start = true
            }
        end
    }

    -- statusline/bufferline
    use {
        'nvim-lualine/lualine.nvim', -- lualine
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end
    }
    use {
        'akinsho/bufferline.nvim', -- bufferline
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup()
        end
    }

    -- cosmetic
    use { "catppuccin/nvim", as = "catppuccin" } -- colorscheme
    -- use 'kyazdani42/nvim-web-devicons'

end)
