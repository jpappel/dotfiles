local Remap = require("keymap")
local builtin = require('telescope.builtin')
local nnoremap = Remap.nnoremap

-- find file
-- TODO: add netrw open bind within context
nnoremap("<Leader>ff", function()
    builtin.find_files()
end)

-- find buffer
nnoremap("<Leader>fb", function()
    builtin.buffers()
end)

-- grep find
nnoremap("<Leader>gf", function()
    builtin.live_grep()
end)

-- lsp find refrences
nnoremap("<Leader>fr", function()
    -- TODO: if lsp supports reference provider and lsp is attached
    -- [telescope.builtin.lsp_*]: server does not support referencesProvider
    if #vim.lsp.get_active_clients({bufnr = 0}) > 0 then
        builtin.lsp_references()
    else
        builtin.grep_string()
    end
end)

-- -- find git, lists git pickers
-- TODO: write picker
-- nnoremap("<leader>fg", function()
--     builtin.
-- end)
