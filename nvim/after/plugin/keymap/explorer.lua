local Remap = require("keymap")

-- TODO: move to separate config file
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

Remap.nnoremap("<leader>ef", function()
    vim.cmd('Vexplore')
end)
