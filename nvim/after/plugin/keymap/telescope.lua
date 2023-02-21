local Remap = require("keymap")
local builtin = require('telescope.builtin')
local nnoremap = Remap.nnoremap

-- find file
nnoremap("<Leader>ff", function()
    builtin.find_files()
end)

-- find buffer
nnoremap("<leader>fb", function()
    builtin.buffers()
end)

-- grep find
nnoremap("<Leader>gf", function()
    builtin.live_grep()
end)

-- -- find git, lists git pickers
-- TODO: write picker
-- nnoremap("<leader>fg", function()
--     builtin.
-- end)
