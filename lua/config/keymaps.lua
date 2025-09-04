-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
-- Git 状态（左侧标记 + 变更操作）
map("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "跳到下一个 Git 变更" })
map("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "跳到上一个 Git 变更" })

-- Git 变更历史（Diffview）
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "当前文件 Git 变更历史" })
map("n", "<leader>go", "<cmd>DiffviewOpen<CR>", { desc = "打开 Git Diff 视图" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "关闭 Git Diff 视图" })

-- LazyGit UI
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "打开 LazyGit" })

-- Preview markdown
map("n", "<leader>mp", "<cmd>!glow %<CR>", { desc = "Preview Markdown in terminal" })

-- Toggle tree log
map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- search filename or content
map("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
