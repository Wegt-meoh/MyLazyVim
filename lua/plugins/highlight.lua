return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- Add Treesitter for syntax highlighting
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "rust",
                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "css",
                    "json",
                    "yaml",
                    "scss",
                    "lua",
                    "bash",
                    "make",
                },
                highlight = { enable = true },
                indent = { enable = true }, -- Auto-indent support
            })
        end,
    },
}
