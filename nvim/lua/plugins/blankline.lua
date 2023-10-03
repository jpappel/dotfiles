-- TODO: configure tree-sitter to color current indentation level
return {
    'lukas-reineke/indent-blankline.nvim', -- show indentation levels
    main = "ibl",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    -- opts = {
    --         show_current_context = true,
    --         show_current_context_start = true,
    --         indent_blankline_use_treesiter = true,
    --     }
}
