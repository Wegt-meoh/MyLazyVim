return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = vim.lsp.config

            -- C
            lspconfig("clangd", {
                cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=WebKit" },
            })

            -- JS/TS – vtsls is still the best in 2025
            lspconfig("vtsls", {
                settings = {
                    vtsls = {
                        autoUseWorkspaceTsdk = true,
                    },
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                    javascript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameter = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
            })

            -- Everything else – perfect defaults
            lspconfig("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
                },
            })
            lspconfig("lua_ls", {
                settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            })
            lspconfig("bashls", {})
            lspconfig("html", {})
            lspconfig("cssls", {})
            lspconfig("jsonls", {})
            lspconfig("yamlls", {})
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" }, -- Lazy-load on save
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                rust = { "rustfmt" },
                lua = { "stylua" },
                sh = { "shfmt" },
                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescript = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                vue = { "eslint_d" },
                css = { "eslint_d" }, -- if you have eslint-plugin-css
                json = { "eslint_d" },
                jsonc = { "eslint_d" },
                html = { "eslint_d" }, -- works if you have prettier-plugin-tailwind or eslint-plugin-html
                graphql = { "eslint_d" },
                markdown = { "eslint_d" },
                yaml = { "eslint_d" },
            },
            format_on_save = { timeout_ms = 500 },
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            -- Linters by filetype (primaries; add more from supported list if needed)
            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                html = { "htmlhint" },
                css = { "stylelint" },
                c = { "clangtidy" },
                rust = { "clippy" },
                yaml = { "yamllint" },
                lua = { "luacheck" },
                sh = { "shellcheck" }, -- Bash filetype is 'sh'
                json = { "jsonlint" },
            }

            -- Auto-trigger linting
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
