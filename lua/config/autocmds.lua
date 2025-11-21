-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
--   pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.py", "*.sh", "*.html", "*.css", "*.lua" },
--   callback = function()
--     vim.lsp.buf.format({ async = false }) -- Format before saving
--     -- Update diagnostics (run linting)
--     vim.diagnostic.setqflist() -- Update quickfix list with linting diagnostics
--   end,
-- })
--
-- Custom :W command: Saves without formatting/autocmds (bypasses BufWritePre)
vim.api.nvim_create_user_command("W", function()
    vim.cmd("noautocmd write")
end, { force = true, desc = "Save without formatting/autocmds" })

-- Your exact classic keymaps (unchanged forever)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local map = function(m, l, r, desc)
            vim.keymap.set(m, l, r, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        map("n", "gk", vim.lsp.buf.hover, "Hover")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = false })
        end, "Format buffer")
    end,
})
