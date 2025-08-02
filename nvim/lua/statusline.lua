local debounce = {
    diagnostic = vim.uv.new_timer(),
    git = vim.uv.new_timer(),
}

local statusline_group = vim.api.nvim_create_augroup("custom.statusline", { clear = false })
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    desc = "Set diagnostic counts for statusline",
    group = statusline_group,
    callback = function(_)
        if debounce.diagnostic:get_due_in() ~= 0 then
            return
        end
        debounce.diagnostic:start(75, 0, function() end)

        local counts = vim.diagnostic.count()
        local s = ''
        for i = 1, 4, 1 do
            if counts[i] ~= nil then
                if #s > 0 then
                    s = s .. ' | '
                end

                if i == 1 then
                    s = s .. "%#DiagnosticError#E:"
                elseif i == 2 then
                    s = s .. "%#DiagnosticWarn#W:"
                elseif i == 3 then
                    s = s .. "%#DiagnosticInfo#I:"
                elseif i == 4 then
                    s = s .. "%#DiagnosticHint#H:"
                end
                s = s .. tostring(counts[i]) .. "%*"
            end
        end
        vim.api.nvim_set_var('diagnosticCounts', s)
    end
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost' }, {
    desc = "Update git info in statusline",
    group = statusline_group,
    callback = function(arg)
        if debounce.git:get_due_in() ~= 0 then
            return
        end
        debounce.git:start(500, 0, function() end)

        if not vim.bo[arg.buf].modifiable then
            return
        end
        vim.system({ "git", "diff", "--numstat", arg.file }, { text = true }, vim.schedule_wrap(function(out)
            if out.code ~= 0 or out.stdout == nil then
                if vim.b["gitDelta"] then
                    vim.api.nvim_buf_del_var(arg.buf, "gitDelta")
                end
            else
                local parts = vim.split(out.stdout, '\t')
                if #parts ~= 3 then
                    return
                end
                local s = "git:" .. "%#DiffAdd#+" .. parts[1] .. "%* " ..
                    "%#DiffDelete#-" .. parts[2] .. "%*"
                vim.api.nvim_buf_set_var(arg.buf, "gitDelta", s)
            end
        end))
    end
})

vim.cmd([[
    func! StatuslineDiagnostics() abort
        if exists("g:diagnosticCounts")
            return g:diagnosticCounts
        else
            return ''
        endif
    endfunc
    func! StatuslineGit() abort
        if exists("b:gitDelta")
            return b:gitDelta
        else
            return ''
        endif
    endfunc
]])

local statusline = {
    left = '%#Search# %{mode()} %* %f %m %= ',
    center = '%{%StatuslineDiagnostics()%} %{%StatuslineGit()%} %= ',
    right = '%-(%#Delimiter#[%#Operator#%R%Y%#Delimiter#]%*%) %#MoreMsg#%11(%4c,%-6l%) %*%#NonText#%3p%% ',
}

return statusline.left .. statusline.center .. statusline.right
