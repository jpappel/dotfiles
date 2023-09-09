return {
    'github/copilot.vim',
    enabled = false,
    -- ft = 
    config = function()
        vim.cmd[[Copilot setup]]
    end
}
