return {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',   -- fuzzy finder
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    keys = {
        {"<leader>ff", function()
            require("telescope.builtin").find_files()
        end,
        desc = "Search for files (respcting .gitignore)"
    },
    {"<leader>fb", function()
        require("telescope.builtin").buffers()
    end
    },
    {"<leader>gf", function()
        require("telescope.builtin").live_grep()
    end
    },
    {"<leader>fq", function()
        require("telescope.builtin").quickfix()
    end
    },
    {"<leader>fl", function()
        require("telescope.builtin").loclist()
    end
    },
    {"<leader>fd", function()
        require("telescope.builtin").diagnostics()
    end
    },
    {"<leader>fr", function()
        -- TODO: if lsp supports reference provider and lsp is attached
        -- [telescope.builtin.lsp_*]: server does not support referencesProvider
        if #vim.lsp.get_active_clients({bufnr = 0}) > 0 then
            require("telescope.builtin").lsp_references()
        else
            require("telescope.builtin").grep_string()
        end
    end
    }
    }
}
