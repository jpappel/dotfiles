return {

    -- common dependacy
    "nvim-lua/plenary.nvim",


    {
        'numToStr/Comment.nvim', -- faster commentting
        event = 'BufEnter',
        opts = {
            mappings = {
                basic = true,
                extra = false
            }
        },
    },

    {
        "j-hui/fidget.nvim",
        event = { 'LspAttach' },
        opts = {}
    },

    {
        'ap/vim-css-color',
        ft = { 'css', 'scss', 'sass' }
    },

    -- cosmetic
    -- 'kyazdani42/nvim-web-devicons',

}
