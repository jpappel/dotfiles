local Remap = require("keymap")

Remap.nmap("gf", function()
    vim.cmd([[:e <cfile>]])
end)
