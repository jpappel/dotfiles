return {

    -- common dependacy
    "nvim-lua/plenary.nvim",


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

    {
        "j-hui/fidget.nvim",
        config = function ()
            require("fidget").setup({})
        end
    },

    {
        'ap/vim-css-color',
        ft = {'css', 'scss', 'sass'}
    }

    -- cosmetic
    -- 'kyazdani42/nvim-web-devicons',

}
