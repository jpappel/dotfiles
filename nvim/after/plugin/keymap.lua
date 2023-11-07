local Remap = require("keymap")

Remap.nmap("gf", function()
    vim.cmd([[:e <cfile>]])
end)

Remap.nnoremap("<Leader>qf", function()
    vim.cmd(':cope')
end)
