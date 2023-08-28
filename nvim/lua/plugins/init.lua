return {

    -- common dependacy
    "nvim-lua/plenary.nvim",

    -- git
    'tpope/vim-fugitive', -- close to native git command integrations


    -- completion
    -- TODO:config completion and setup binds
    'hrsh7th/nvim-cmp',
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = { {'hrsh7th/nvim-cmp'}, {'neovim/nvim-lspconfig'} }
    },
    {
        'hrsh7th/cmp-path',
        dependencies = { 'hrsh7th/nvim-cmp' }
    },
    {
        'kdheepak/cmp-latex-symbols',
        dependencies = { 'hrsh7th/nvim-cmp' }
    },




    {
        'numToStr/Comment.nvim', -- faster commentting
        lazy = false,
        opts = {
            mappings = {
                basic = true,
                extra = false
            }
        },
        -- config = function()
        --     require('Comment').setup()
        -- end
    },

    -- cosmetic
    -- 'kyazdani42/nvim-web-devicons',

}
