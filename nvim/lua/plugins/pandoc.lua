return {
    {
        'vim-pandoc/vim-pandoc',
        ft = {"markdown", "pandoc"},
        keys = {
            {'gO', vim.cmd.TOC, desc = "Markdown file Table of Contents"}
        }
    },
    {
        'vim-pandoc/vim-pandoc-syntax',
        ft = {"markdown", "pandoc"}
    }
}
