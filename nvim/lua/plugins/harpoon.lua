return {
    'ThePrimeagen/harpoon', -- quick file navigator
    branch = "harpoon2",
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require("harpoon"):setup()
    end,
    keys = {
        {
            "<leader><cr>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Open Harpoon Quickmenu"
        },
        {
            "<leader>m",
            function()
                local harpoon = require("harpoon")
                harpoon:list():append()
            end,
            desc = "Add file to harpoon"
        },
        {
            "<leader>1",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(1)
            end,
            desc = "Navigate to the first file"
        },
        {
            "<leader>2",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(2)
            end,
            desc = "Navigate to the second file"
        },
        {
            "<leader>3",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(3)
            end,
            desc = "Navigate to the third file"
        },
        {
            "<leader>4",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(4)
            end,
            desc = "Navigate to the fourth file"
        },
    }
}
