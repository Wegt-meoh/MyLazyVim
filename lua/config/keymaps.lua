-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
-- Git 状态（左侧标记 + 变更操作）
map("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "跳到下一个 Git 变更" })
map("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "跳到上一个 Git 变更" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "预览 Git 变更" })
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "阶段（Stage）变更" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "撤销（Undo）变更" })

-- Git 交互（Fugitive）
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "打开 Git 状态界面" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git 提交" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git 推送" })
map("n", "<leader>gl", "<cmd>Git pull<CR>", { desc = "Git 拉取" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git Diff 视图" })
map("n", "<leader>gb", "<cmd>Gblame<CR>", { desc = "Git Blame" })

-- Git 变更历史（Diffview）
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "当前文件 Git 变更历史" })
map("n", "<leader>go", "<cmd>DiffviewOpen<CR>", { desc = "打开 Git Diff 视图" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "关闭 Git Diff 视图" })

-- Git 冲突解决
map("n", "<leader>co", "<cmd>GitConflictChooseOurs<CR>", { desc = "选择本地版本" })
map("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<CR>", { desc = "选择远程版本" })
map("n", "<leader>cb", "<cmd>GitConflictChooseBase<CR>", { desc = "选择基准版本" })
map("n", "<leader>cn", "<cmd>GitConflictNextConflict<CR>", { desc = "跳到下一个冲突" })

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
