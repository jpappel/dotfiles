local M = {}

local cmd_pcall = function (string)
    local success, msg = pcall(function() vim.cmd(string) end)
    if not success then
        msg = string.match(tostring(msg), "E%d+.*")
        vim.api.nvim_err_writeln(msg)
    end
end

vim.keymap.set('n', 'gf', function() cmd_pcall(':e <cfile>') end, {noremap = true})
vim.keymap.set('n', "<Leader>q", function() vim.cmd(':botright cope') end)
vim.keymap.set('n', "<Leader>l", function() cmd_pcall(':aboveleft lope') end)

vim.keymap.set('n',"<Leader>k", function() vim.cmd("make") end)

vim.keymap.set('t', "<ESC><ESC>", "<c-\\><c-n>")

vim.api.nvim_create_autocmd('LspAttach', {
    buffer = 0,
    callback = function(args)
        local opts = {
            buffer = 0,
            silent = true
        }
        vim.keymap.set('n', "==", function () vim.lsp.buf.format() end, opts)
        -- vim.keymap.set('v', "=", function () vim.lsp.buf.format() end, opts)
    end,
    desc = "Change `==` to `vim.lsp.buf.format()` when available"
})

return M
