return {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    cmd = 'Telescope',
    keys = {
        {
            "<leader>ff",
            function()
                local builtin = require("telescope.builtin")
                builtin.find_files()
            end,
            desc = "Search for files (respcting .gitignore) using Telescope"
        },
        {
            "<leader>fF",
            function()
                require("telescope.builtin").find_files({ hidden = true, no_ignore_parent = true })
            end,
            desc = "Search for files (including hidden) using Telescope"
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Search for open buffers using Telescope"
        },
        { "<leader>fg", function()
            require("telescope.builtin").live_grep()
        end
        },
        {
            "<leader>fq",
            function()
                local themes = require("telescope.themes")
                require("telescope.builtin").quickfix(themes.get_ivy({}))
            end,
            desc = "Search in the the quickfix buffer using Telescope"
        },
        {
            "<leader>fl",
            function()
                local themes = require("telescope.themes")
                require("telescope.builtin").loclist(themes.get_ivy({}))
            end,
            desc = "Search within a location list using Telescope"
        },
        {
            "<leader>fd",
            function()
                local themes = require("telescope.themes")
                require("telescope.builtin").diagnostics(themes.get_ivy({}))
            end,
            desc = "Search through diagnostics using Telescope"
        },
        {
            "<leader>fr",
            function()
                -- TODO: if lsp supports reference provider and lsp is attached
                -- [telescope.builtin.lsp_*]: server does not support referencesProvider
                local themes = require("telescope.themes")
                if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
                    require("telescope.builtin").lsp_references(themes.get_ivy({}))
                else
                    require("telescope.builtin").grep_string(themes.get_ivy({}))
                end
            end,
            desc = "Search for refences via grep or a language server using Telescope"
        }
    }
}
