local shared = require('shared')

local M = {}

-- disable ctrl-f to work nicer with telescope binds
vim.keymap.set('n', '<C-f>', '<NOP>')

vim.keymap.set('n', 'gf', function() shared.cmd_pcall(':e <cfile>') end, { noremap = true })
vim.keymap.set('n', "<Leader>q", function()
        if vim.o.ft == "qf" then
            vim.cmd('ccl')
        else
            vim.cmd('botright cope')
        end
    end,
    { noremap = true, desc = "Toggle bottom quickfix window" })
vim.keymap.set('n', "<Leader>l", function()
        if vim.o.ft == "qf" then
            vim.cmd('lcl')
        else
            shared.cmd_pcall(':aboveleft lope')
        end
    end,
    { noremap = true, desc = "Toggle localtion window" })
vim.keymap.set('n', "<Leader>dk", function() vim.diagnostic.open_float() end)

-- Send visual selection to quickfix list
vim.keymap.set('v', "<C-q>", function()
    local visual = shared.get_visual()

    local line_nums = {}
    for i = visual.range.start, visual.range.stop, 1 do
        table.insert(line_nums, i)
    end

    shared.send_to_qf(visual.lines, line_nums)
    vim.cmd('botright cope')
end, { noremap = true, desc = "Send visual selection to quickfix list" })


-- Move visual selection with J and K
vim.keymap.set('v', "J", function()
    shared.vert_shift_selection(1)
end, { noremap = true, desc = "shift visual selection down" })
vim.keymap.set('v', "K", function()
    shared.vert_shift_selection(-1)
end, { noremap = true, desc = "shift visual selection up" })

vim.keymap.set('n', "<Leader>k", "<cmd>make<cr>")

vim.keymap.set('t', "<ESC><ESC>", "<c-\\><c-n>")

return M
