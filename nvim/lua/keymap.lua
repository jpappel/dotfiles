local M = {}

local cmd_pcall = function(string)
    local success, msg = pcall(function() vim.cmd(string) end)
    if not success then
        msg = string.match(tostring(msg), "E%d+.*")
        vim.api.nvim_err_writeln(msg)
    end
end

local function send_to_qf(lines, line_nums)
    local bufnr = vim.api.nvim_get_current_buf()
    local qf_items = {}
    for i, line in ipairs(lines) do
        if line:match("^%s*$") == nil then
            table.insert(qf_items, { bufnr = bufnr, lnum = line_nums[i], text = line })
        end
    end
    vim.fn.setqflist(qf_items, 'r')
end

vim.keymap.set('n', 'gf', function() cmd_pcall(':e <cfile>') end, { noremap = true })
vim.keymap.set('n', "<Leader>q", function()
        if vim.o.ft == "qf" then
            vim.cmd('ccl')
        else
            vim.cmd('botright cope')
        end
    end,
    { noremap = true, desc = "Toggle bottom quickfix window" })
vim.keymap.set('n', "<Leader>l", function() cmd_pcall(':aboveleft lope') end)
vim.keymap.set('n', "<Leader>dk", function() vim.diagnostic.open_float() end)
vim.keymap.set('n', "[q", "<cmd>cprev<cr>", { noremap = true })
vim.keymap.set('n', "]q", "<cmd>cnext<cr>", { noremap = true })

-- Send visual selection to quickfix list
vim.keymap.set('v', "<C-q>", function()
    -- return to normal mode to correctly set '< and '> marks
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'x', false)

    local range = { start = vim.api.nvim_buf_get_mark(0, "<")[1], stop = vim.api.nvim_buf_get_mark(0, ">")[1] }

    local line_nums = {}
    local lines = vim.api.nvim_buf_get_lines(0, range.start - 1, range.stop, false)

    for i = range.start, range.stop, 1 do
        table.insert(line_nums, i)
    end

    send_to_qf(lines, line_nums)
    vim.cmd('botright cope')
end, { noremap = true, desc = "Send visual selection to quickfix list" })

-- Shift the visual selection by amount, clamping to buffer size
--- @param amount integer
local function vert_shift_selection(amount)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'x', false)

    local init = { start = vim.api.nvim_buf_get_mark(0, '<'), stop = vim.api.nvim_buf_get_mark(0, '>') }
    local target = {
        start = { init.start[1] + amount, init.start[2] },
        stop = { init.stop[1] + amount, init.stop[2] }
    }

    local linecount = vim.api.nvim_buf_line_count(0)
    if target.start[1] < 1 then
        target.start[1] = 1
        target.stop[1] = 1 + (init.stop[1] - init.start[1])
    elseif target.stop[1] > linecount then
        target.stop[1] = linecount
        target.start[1] = linecount - (target.stop[1] - target.start[1])
    end

    -- HACK: should be shifted into target calculation
    if target.stop[1] > linecount or target.start[1] < 1 then
        return
    end

    -- shift lines
    if amount < 0 then
        vim.cmd("'<,'>mo '<" .. amount - 1)
    elseif amount > 0 then
        vim.cmd("'<,'>mo '>+" .. amount)
    end

    -- update marks
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_mark(bufnr, '<', target.start[1], target.start[2], {})
    vim.api.nvim_buf_set_mark(bufnr, '>', target.stop[1], target.stop[2], {})

    vim.cmd("normal! gv")
end

-- Move visual selection with J and K
vim.keymap.set('v', "J", function()
    vert_shift_selection(1)
end, { noremap = true, desc = "shift visual selection down" })
vim.keymap.set('v', "K", function()
    vert_shift_selection(-1)
end, { noremap = true, desc = "shift visual selection up" })

vim.keymap.set('n', "<Leader>k", "<cmd>make<cr>")

vim.keymap.set('t', "<ESC><ESC>", "<c-\\><c-n>")
return M
