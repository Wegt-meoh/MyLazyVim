-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here-- Set custom colors for blame text
vim.api.nvim_set_hl(0, "GitsignsCurrentLineBlame", { fg = "#ff79c6", bg = "#282a36" })

vim.opt.number = true
vim.opt.tabstop = 4 -- 设定 Tab 宽度为 4
vim.opt.shiftwidth = 4 -- 自动缩进的宽度也是 4
vim.opt.expandtab = true -- 使用空格替代 Tab

vim.diagnostic.config({
    virtual_text = false, -- Disable inline text
})

vim.keymap.set("n", "K", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { noremap = true, silent = true })

-- folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99 -- Start with all folds open

vim.o.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- status line
vim.opt.laststatus = 3
vim.o.statusline = "%<%f%m%r%h%w  │  %{&ft==''?'[no ft]':&ft}  │  %l:%c  %p%%/%L"
