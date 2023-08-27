return {
    'akinsho/bufferline.nvim', -- bufferline
    version = "v4.*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({
            options = {
                mode = "tabs",
                show_tab_indicators = false,
                hover = {
                    enabled = true,
                    delay = 200
                }
            }
        })
    end
}
