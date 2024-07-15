return {
    'akinsho/bufferline.nvim', -- bufferline
    version = "v4.*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            mode = "tabs",
            show_tab_indicators = false,
            hover = {
                enabled = true,
                delay = 200
            }
        }
    }
}
