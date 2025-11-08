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

    {
        -- Git UI（LazyGit）
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
