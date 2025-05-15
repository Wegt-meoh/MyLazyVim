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
                    "styled",
                },
                highlight = { enable = true, additional_vim_regex_highlighting = false, },
                indent = { enable = true }, -- Auto-indent support
                injections = { enable = true, },
                fold = { enable = true },
            })
        end,
    },
}
