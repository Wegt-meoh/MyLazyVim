local map = vim.keymap.set

local no_diagnostic_servers = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright" }
local on_attach = function(client, buffer)
    -- Disable LSP Diagnostics (Linting)
    if vim.tbl_contains(no_diagnostic_servers, client.name) then
        client.server_capabilities.diagnosticsProvider = false
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
    end

    local opts = { noremap = true, silent = true, buffer = buffer }
    map("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

return {
    -- LSP (Language Server Protocol)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, lsp in ipairs(no_diagnostic_servers) do
                lspconfig[lsp].setup({
                    capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Enable autocompletion
                    on_attach = on_attach,
                })
            end

            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy", -- Use `clippy` for advanced linting on save
                        },
                        cargo = {
                            allFeatures = true, -- Enable all Cargo features
                        },
                    },
                },
            })

            lspconfig.yamlls.setup({
                cmd = { "yaml-language-server", "--stdio" },
                filetypes = { "yaml", "yml" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["http://json.schemastore.org/github-workflow"] = "/.github/workflows/*",
                            ["http://json.schemastore.org/ansible-playbook-2.0"] = "/ansible/**/*.yml",
                        },
                    },
                },
            })
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- 🖊️ Formatters
                    null_ls.builtins.formatting.black, -- Python
                    null_ls.builtins.formatting.shfmt, -- Shell

                    -- 🔍 Linters
                    require("none-ls.diagnostics.eslint_d"), -- JavaScript/TypeScript
                    null_ls.builtins.diagnostics.selene,     -- Lua
                    null_ls.builtins.diagnostics.mypy,       -- python

                    -- 🔧 Code Actions
                    null_ls.builtins.code_actions.gitsigns,   -- Git staging actions
                    require("none-ls.code_actions.eslint_d"), -- JavaScript/TypeScript
                },
                on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false }) -- Format before saving
                        end,
                    })

                    vim.api.nvim_create_autocmd("BufWritePost", {
                        buffer = bufnr,
                        callback = function()
                            vim.diagnostic.setqflist({ open = false }) -- Update Quickfix List
                            local diagnostics = vim.diagnostic.get()
                            if #diagnostics > 0 then
                                vim.cmd("copen") -- Open Quickfix List if there are errors/warnings
                            else
                                vim.cmd("cclose")
                            end
                        end,
                    })
                end,
            })
        end,
    },

    {
        "kampfkarren/selene",
        dependencies = { "neovim/nvim-lspconfig" },
    },
}
