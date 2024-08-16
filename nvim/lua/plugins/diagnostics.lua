return {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
        {
            "<leader>df",
            function()
                local trouble = require("trouble")
                local opts = {
                    mode = "diagnostics",
                    focus = true,
                    follow = false
                }
                if trouble.is_open(opts) then
                    trouble.close(opts)
                else
                    trouble.open(opts)
                end
            end,
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>dF",
            function()
                local trouble = require("trouble")
                local opts = {
                    mode = "diagnostics",
                    focus = true,
                    follow = false,
                    filter = { buf = 0 }
                }
                if not trouble.is_open(opts) then
                    trouble.open(opts)
                    trouble.focus(opts)
                else
                    trouble.close(opts)
                end
            end,
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "[d",
            function()
                require("trouble").prev({ mode = "diagnostics", jump = true })
            end,
            desc = "Previous project wide diagnostic"
        },
        {
            "]d",
            function()
                require("trouble").next({ mode = "diagnostics", jump = true })
            end,
            desc = "Next project wide diagnostic"
        },
        {
            "<leader>dl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>dq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
