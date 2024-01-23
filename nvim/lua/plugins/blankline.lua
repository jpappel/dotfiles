-- TODO: configure tree-sitter to color current indentation level
return {
    'lukas-reineke/indent-blankline.nvim', -- show indentation levels
    main = "ibl",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
        scope = { enabled = true }
        }
}
