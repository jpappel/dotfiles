local M = {}

-- pcall a vim command
function M.cmd_pcall(string)
    local success, msg = pcall(function() vim.cmd(string) end)
    if not success then
        msg = string.match(tostring(msg), "E%d+.*")
        vim.api.nvim_err_writeln(msg)
    end
end

--- Get the lines of a visual selection
--- @return { lines : string[], range : { start : integer, stop : integer } }
M.get_visual = function()
    -- return to normal mode to correctly set '< and '> marks
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'x', false)

    local range = { start = vim.api.nvim_buf_get_mark(0, "<")[1], stop = vim.api.nvim_buf_get_mark(0, ">")[1] }

    local lines = vim.api.nvim_buf_get_lines(0, range.start - 1, range.stop, false)

    return { lines = lines, range = range }
end

-- send lines from the current buffer to quickfix
--- @param lines string[]
--- @param line_nums integer[]
function M.send_to_qf(lines, line_nums)
    local bufnr = vim.api.nvim_get_current_buf()
    local qf_items = {}
    for i, line in ipairs(lines) do
        if line:match("^%s*$") == nil then
            table.insert(qf_items, { bufnr = bufnr, lnum = line_nums[i], text = line })
        end
    end
    vim.fn.setqflist(qf_items, 'r')
end

-- Shift the visual selection by amount, clamping to buffer size
--- @param amount integer
function M.vert_shift_selection(amount)
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

return M
