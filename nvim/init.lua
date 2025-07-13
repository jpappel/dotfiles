-- ====================
-- 	NVIM CONFIG
-- ====================

HOME = os.getenv("HOME")
HOSTNAME = vim.uv.os_gethostname()

-- bootstrap lazynvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup('plugins', {
    dev = {
        path = "~/src"
    }
})
require('keymap')


-- General Config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.mouse = "anv"

--change mouse menu
vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.api.nvim_command('aunmenu PopUp.-1-')

-- Sign column
vim.opt.signcolumn = "yes"

-- Status line
vim.opt.laststatus = 3

local statusline_group = vim.api.nvim_create_augroup("custom.statusline", { clear = false })
-- PERF: this event fires often, should consider debouncing it
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    desc = "Set diagnostic counts for statusline",
    group = statusline_group,
    callback = function(_)
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

-- PERF: consider debouncing
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost' }, {
    desc = "Update git info in statusline",
    group = statusline_group,
    callback = function(arg)
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

vim.opt.statusline =
'%-t %= %-{%StatuslineDiagnostics()%} %1(%M%) %{%StatuslineGit()%} %= %-([%R%Y]%) %#LineNr#%c,%l%* %#LineNrAbove#%3p%%'

vim.opt.showtabline = 1

vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:·,nbsp:·,extends:+,lead:·"

-- tab settings (space supremacy :) )
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Bell
vim.opt.errorbells = false
vim.opt.visualbell = true

-- term settings
vim.opt.termguicolors = true

-- tex syntax highlighting
vim.g.tex_flavor = "latex"

-- ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- netrw config
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- project local settings
vim.opt.exrc = true
