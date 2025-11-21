return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "stevearc/conform.nvim",
    },
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
        lspconfig("rust_analyzer", {})
        lspconfig("lua_ls", {
            settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        })
        lspconfig("bashls", {})
        lspconfig("html", {})
        lspconfig("cssls", {})
        lspconfig("jsonls", {})
        lspconfig("yamlls", {})

        -- Formatting – conform.nvim (2025 standard)
        require("conform").setup({
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
        })
    end,
}
