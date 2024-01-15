-- Provides convienent lua methods for binding keys
-- Source: Primeagen
local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

M.nnoremap("gf", function() vim.cmd([[:e <cfile>]]) end)
M.nnoremap("<Leader>q", function() vim.cmd(':botright cope') end)
M.nnoremap("<Leader>l", function()
    local success, err_msg = pcall(function()
        vim.cmd(':aboveleft lope')
    end)
    if not success then
        err_msg = string.match(tostring(err_msg), "E%d+.*")
        vim.api.nvim_err_writeln(err_msg)
    end
end)
M.nnoremap("<leader>ef", function()
    vim.cmd('Vexplore')
end)

return M
