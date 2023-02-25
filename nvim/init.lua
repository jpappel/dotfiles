-- ====================
-- 	NVIM CONFIG
-- ====================

HOME = os.getenv("HOME")

require('keymap')
require('plugins')
require('colorscheme')
-- require('statusline')
-- require('bufferline')

-- General Config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.mouse = "anv"

-- Status line
vim.opt.laststatus = 3

vim.opt.showtabline = 2

vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:·,nbsp:·,extends:+,lead:·"

-- tab settings
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


-- leader
vim.g.mapleader = " "

-- tex syntax highlighting
vim.g.tex_flavor = "latex"
