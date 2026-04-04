return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
        local nvim_treesitter = require("nvim-treesitter")
        local util = require("nvim.lua.shared")

        local installed = util.to_set(nvim_treesitter.get_installed())
        local ensure_installed = util.to_set {
            "markdown", "markdown_inline",
            "vimdoc",
            "c",
            "make",
            "rust",
            "go", "gowork", "gotmpl",
            "json", "yaml", "toml",
            "python",
            "html",
            "javascript",
            "julia", "r",
            "bash",
            "latex",
            "sql",
        }

        local diff = util.set_difference(ensure_installed, installed)
        if #diff > 0 then
            -- NOTE: potential race condition because install is async
            nvim_treesitter.install(util.keys(diff))
        end

        nvim_treesitter.update({ summary = true })
    end,
}
