return {
    -- file searching
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    -- Your default options here
                    mappings = {
                        i = {
                            ["<C-n>"] = "move_selection_next",
                            ["<C-p>"] = "move_selection_previous",
                        },
                    },
                },
            })
        end,
    },
}
