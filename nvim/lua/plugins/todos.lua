return {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    opts = {},
    cmd = {
        'TodoQuickFix',
        'TodoLocList',
        'TodoTrouble',
        'TodoTelescope'
    },
    keys = {
        {
            "<leader>tf",
            function()
                local trouble = require("trouble")
                local opts = {
                    mode = "todo",
                    focus = true,
                    follow = false
                }
                if trouble.is_open(opts) then
                    if vim.o.ft == "trouble" then
                        trouble.close(opts)
                    else
                        trouble.focus()
                    end
                else
                    trouble.open(opts)
                end
            end,
            mode = 'n',
            desc = "Open todo comments in a trouble window"
        },
        {
            "<leader>tF",
            function()
                local trouble = require("trouble")
                local opts = {
                    mode = "todo",
                    focus = true,
                    follow = false,
                    filter = { buf = 0 }
                }
                if trouble.is_open(opts) then
                    if vim.o.ft == "trouble" then
                        trouble.close(opts)
                    else
                        trouble.focus()
                    end
                else
                    trouble.open(opts)
                end
            end,
            mode = 'n',
            desc = "Open buffer local todo comments in a trouble window"
        },
        {
            "<leader>tq",
            "<cmd>TodoQuickFix<cr>",
            mode = 'n',
            desc = "Quickfix List (Todo Comments)"
        },
        {
            "<leader>tl",
            "<cmd>TodoLocList<cr>",
            mode = 'n',
            desc = "Location List (Todo Comments)"
        },
        {
            "]t",
            function()
                require('trouble').next({ mode = "todo", jump = true })
            end,
            mode = 'n',
            desc = "Next todo comment"
        },
        {
            "[t",
            function()
                require('trouble').prev({ mode = "todo", jump = true })
            end,
            mode = 'n',
            desc = "Previous todo comment"
        },
        {
            "<leader>ft",
            "<cmd>TodoTelescope<cr>",
            mode = 'n',
            desc = "Open Todos in quickfix list"
        }
    }
}
