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
}
