return {
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    -- Install with Lazy.nvim
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            lsp = {
                hover = {
                    enabled = true,
                    silent = false, -- disable "No information available" message
                    border = "rounded",
                },
            },
        },
    }
}
