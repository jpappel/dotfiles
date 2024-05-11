return {
    "allaman/emoji.nvim",
    ft = {
        "markdown",
        "pandoc"
    },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("emoji").setup({ enable_cmp_integration = true })
        require("telescope").load_extension("emoji")
    end
}
