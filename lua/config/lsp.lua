-- 不需要再安装 "neovim/nvim-lspconfig" 插件
-- 直接在你的 init.lua 或对应的配置文件中添加以下代码

-- ============================================
-- LSP 配置（Neovim 0.12 内置 API）
-- ============================================

-- 1. 定义各个 LSP 服务器的配置
vim.lsp.config.clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=WebKit" },
    filetypes = { "c", "cpp" },
    root_markers = { ".git", "compile_commands.json", "Makefile" },
}

vim.lsp.config.vtsls = {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
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
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
    },
}

vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy", -- 使用 clippy 进行检查
            },
            -- 可选：启用更多 inlay hints
            inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "always" },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "always" },
                renderColons = true,
                typeHints = { enable = true },
            },
        },
    },
}

vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}

vim.lsp.config.bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git", ".bashrc" },
}

vim.lsp.config.html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "htmldjango" },
    root_markers = { "package.json", ".git" },
}

vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
}

vim.lsp.config.jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { "package.json", ".git" },
}

vim.lsp.config.yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { ".git", ".yamllint" },
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.yml",
            },
        },
    },
}

-- 2. 启用需要的 LSP 服务器
vim.lsp.enable("clangd")
vim.lsp.enable("vtsls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")

-- ============================================
-- 可选：自动开启 Inlay Hints
-- ============================================
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- 自动开启 inlay hints（类型提示）
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        -- 可选：设置快捷键（虽然 Neovim 0.12 已有默认值，但可以按习惯覆盖）
        -- 这里只列出一些常用的，你也可以完全信任默认值
        local opts = { buffer = args.buf, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    end,
})

-- ============================================
-- 可选：设置 LSP 日志级别（调试用）
-- ============================================
-- vim.lsp.set_log_level("debug")
