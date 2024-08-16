-- ====================
-- 	NVIM CONFIG
-- ====================

HOME = os.getenv("HOME")
HOSTNAME = vim.loop.os_gethostname()

-- bootstrap lazynvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
-- TODO: include local plugins

-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup('plugins')
require('keymap')


-- General Config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.mouse = "anv"

--change mouse menu
vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.api.nvim_command('aunmenu PopUp.-1-')

-- Status line
vim.opt.laststatus = 3

vim.opt.showtabline = 1

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

-- tex syntax highlighting
vim.g.tex_flavor = "latex"

-- ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- netrw config
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
