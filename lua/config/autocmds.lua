-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.py", "*.sh", "*.html", "*.css", "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = false }) -- Format before saving
    -- Update diagnostics (run linting)
    vim.diagnostic.setqflist() -- Update quickfix list with linting diagnostics
  end,
})
