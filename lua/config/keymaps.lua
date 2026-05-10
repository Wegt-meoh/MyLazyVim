-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Git 状态（左侧标记 + 变更操作）
map("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "跳到下一个 Git 变更" })
map("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "跳到上一个 Git 变更" })

-- diagnostic
map("n", "[d", "<Nop>")
map("n", "]d", "<Nop>")
map("n", "]e", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map("n", "[e", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
map("n", "K", function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end, { noremap = true, silent = true })

-- LazyGit UI
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "打开 LazyGit" })

-- Toggle tree log
map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- search filename or content
map("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })

-- markdown preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true, desc = "MarkdownPreview" })
map("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true, desc = "MarkdownPreviewStop" })
map("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true, desc = "MarkdownPreviewToggle" })

-- Define movement mappings for both style sets
local move_keys = {
  -- hjkl style
  { "<A-j>", "<A-k>", "<A-h>", "<A-l>" },
  -- Arrow style
  { "<A-Down>", "<A-Up>", "<A-Left>", "<A-Right>" },
}
-- Normal mode: Move current line
for _, keys in ipairs(move_keys) do
  vim.keymap.set("n", keys[1], ":m .+1<CR>==", { desc = "Move line down" }) -- down/j
  vim.keymap.set("n", keys[2], ":m .-2<CR>==", { desc = "Move line up" }) -- up/k
end
-- Visual mode: Move selected line(s)
for _, keys in ipairs(move_keys) do
  vim.keymap.set("v", keys[1], ":m '>+1<CR>gv", { desc = "Move line(s) down" }) -- down/j
  vim.keymap.set("v", keys[2], ":m '<-2<CR>gv", { desc = "Move line(s) up" }) -- up/k
  vim.keymap.set("v", keys[3], "<gv", { desc = "Move selection right" }) -- right/l
  vim.keymap.set("v", keys[4], ">gv", { desc = "Move selection left" }) -- left/h
end
