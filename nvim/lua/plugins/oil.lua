local oil_winnr = nil
return {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        default_file_explorer = true,
    },
    keys = { {
        "<leader>ef",
        function()
            if not oil_winnr or not vim.api.nvim_win_is_valid(oil_winnr) then
                vim.cmd("topleft vsplit +Oil")
                oil_winnr = vim.api.nvim_get_current_win()
                return
            end

            if vim.api.nvim_get_current_win() == oil_winnr then
                vim.api.nvim_win_close(oil_winnr, false)
                oil_winnr = nil
            else
                vim.api.nvim_set_current_win(oil_winnr)
            end
        end,
        desc = "Open Oil file explorer in a far left split, similar to :Lexplore"
    } },
    cmd = "Oil"
}
