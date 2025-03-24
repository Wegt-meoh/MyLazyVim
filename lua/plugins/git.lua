return {
    {
        -- Git 状态显示（左侧标记 + 变更预览）
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                current_line_blame = true, -- 显示当前行的 Git 提交信息
            })
        end,
    },

    -- Git 交互界面（`G`、`Gdiffsplit`、`Gblame`）
    "tpope/vim-fugitive",

    {
        -- Git Diff 视图（查看变更历史）
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({})
        end,
    },

    {
        -- 解决 Git 冲突
        "akinsho/git-conflict.nvim",
        config = function()
            require("git-conflict").setup()
        end,
    },

    {
        -- Git UI（LazyGit）
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
