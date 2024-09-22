local M = {}

local cmd_pcall = function(string)
    local success, msg = pcall(function() vim.cmd(string) end)
    if not success then
        msg = string.match(tostring(msg), "E%d+.*")
        vim.api.nvim_err_writeln(msg)
    end
end

local function send_to_qf(bufnr, lines, line_nums)
    local qf_items = {}
    for i, line in ipairs(lines) do
        if line:match("^%s*$") == nil then
            table.insert(qf_items, { bufnr = bufnr, lnum = line_nums[i], text = line })
        end
    end
    vim.fn.setqflist(qf_items, 'r')
end

vim.keymap.set('n', 'gf', function() cmd_pcall(':e <cfile>') end, { noremap = true })
vim.keymap.set('n', "<Leader>q", function() vim.cmd('botright cope') end)
vim.keymap.set('n', "<Leader>l", function() cmd_pcall(':aboveleft lope') end)
vim.keymap.set('n', "<Leader>dk", function() vim.diagnostic.open_float() end)

vim.keymap.set('v', "<C-q>", function()
        -- return to normal mode to correctly set '< and '> marks
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'x', false)

        local bufnr = vim.api.nvim_get_current_buf()
        local start_line = vim.fn.getpos("'<")[2]
        local end_line = vim.fn.getpos("'>")[2]

        local line_nums = {}
        local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line+1, false)

        for i = start_line, end_line, 1 do
            table.insert(line_nums, i)
        end

        send_to_qf(bufnr, lines, line_nums)
        vim.cmd('botright cope')
    end,
    { noremap = true, desc = "Send visual selection to quickfix list" })

vim.keymap.set('n', "<Leader>k", function() vim.cmd("make") end)

vim.keymap.set('t', "<ESC><ESC>", "<c-\\><c-n>")

return M
