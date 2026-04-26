return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                -- Ensure the tree's root always matches Neovim's current working directory
                sync_root_with_cwd = true,

                -- Watch for when you focus on a different file
                update_focused_file = {
                    enable = true,
                    -- Update the root of the tree to the folder containing the focused file
                    update_root = true,
                },

                actions = {
                    change_dir = {
                        -- This is the most important setting to make directory changes global
                        global = true,
                    },
                },
                view = {
                    width = 30,
                    side = "left",
                    adaptive_size = true,
                },
                renderer = {
                    icons = {
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                        },
                    },
                },
                git = {
                    enable = true,
                },
            })
        end,
    },
    { "nvim-tree/nvim-web-devicons" },
}
